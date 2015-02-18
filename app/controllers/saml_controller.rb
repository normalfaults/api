class SamlController < ApplicationController

  def callback
    @saml_info = params
  end
end
