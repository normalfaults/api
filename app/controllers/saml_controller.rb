class SamlController < ApplicationController
  before_action :saml_enabled?

  def init
    redirect_to idp_login_request_url request
  end

  def consume
    response = idp_response params
    response.settings = saml_settings request
    if response.is_valid?
      user = Staff.find_by email: response_email(response)
      return saml_failure if user.nil?
      sso_sign_in user
      redirect_to @settings[:redirect_url]
    else
      saml_failure
    end
  end

  private

  def saml_enabled?
    @settings = Setting.find_by(hid: 'saml').settings_hash
    return saml_failure unless @settings[:enabled]
    true
  end

  def saml_failure
    head 404, content_type: :plain
    false
  end

  def response_email(response)
    [
      response.name_id,
      response.attributes['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress'],
      response.attributes['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/upn']
    ].find { |v| v[/^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Z‌​a-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$/i] }
  end

  def idp_response(params)
    OneLogin::RubySaml::Response.new(params[:SAMLResponse])
  end

  def saml_settings(request)
    settings = OneLogin::RubySaml::Settings.new

    settings.assertion_consumer_service_url = saml_consume_url host: request.host
    settings.issuer = "http://#{request.port == 80 ? request.host : request.host_with_port}"
    settings.idp_sso_target_url = @settings[:target_url]
    settings.idp_cert = @settings[:certificate]
    settings.idp_cert_fingerprint = @settings[:fingerprint]
    settings.authn_context = 'urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport'

    settings
  end

  def idp_login_request_url(request)
    idp_request = OneLogin::RubySaml::Authrequest.new
    idp_request.create saml_settings request
  end
end
