class SamlController < ApplicationController

  before_action :load_saml_settings

  def callback
    response = OneLogin::RubySaml::Response.new(params[:SAMLResponse])
    response.settings = @saml_settings
    @saml_info = response
  end

  private

  def load_saml_settings
    @settings = Setting.find_by(hid: 'saml').settings_hash

    p @settings

    unless @settings[:enabled]
      head 404, content_type: :plain
      return false
    end

    @saml_settings = OneLogin::RubySaml::Settings.new

    @saml_settings.assertion_consumer_service_url = "http://#{request.host}/saml/finalize"
    @saml_settings.issuer = @settings[:issuer]
    @saml_settings.idp_sso_target_url = @settings[:url]
    #@saml_settings.idp_entity_id = "https://app.onelogin.com/saml/metadata/#{OneLoginAppId}"
    @saml_settings.idp_cert_fingerprint = @settings[:fingerprint]
    @saml_settings.name_identifier_format = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
  end

end
