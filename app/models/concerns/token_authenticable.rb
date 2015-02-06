module TokenAuthenticable
  extend ActiveSupport::Concern

  # Please see https://gist.github.com/josevalim/fb706b1e933ef01e4fb6
  # before editing this file, the discussion is very interesting.

  included do
    attr_accessor :secret

    before_save :ensure_authentication_token
  end

  def token?(token)
    ::BCrypt::Password.new(authentication_token) == token
  end

  def ensure_authentication_token
    return unless authentication_token.blank?
    self.authentication_token = generate_authentication_token
  end

  private

  def generate_authentication_token
    self.secret = SecureRandom.urlsafe_base64 32 unless secret
    self.authentication_token = ::BCrypt::Password.create(secret, cost: cost)
  end

  def cost
    Rails.env.test? ? 1 : 10
  end

  module ClassMethods
    # nop
  end
end
