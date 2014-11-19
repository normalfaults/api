class SessionsController < Devise::SessionsController
  extend Apipie::DSL::Concern

  respond_to :json

  api :POST, '/staff/sign_in', 'Signs user in'
  param :staff, Hash, desc: 'Staff' do
    param :email, String, desc: 'Email'
    param :email, String, desc: 'Password'
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    respond_with resource
  end

  api :DELETE, '/staff/sign_out', 'Invalidates user session'

  def destroy
    if resource
      Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
      render json: {}, status: :ok
    else
      render json: {}, status: :unprocessable_entity
    end
  end
end
