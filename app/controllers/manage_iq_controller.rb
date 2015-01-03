class ManageIqController < ApplicationController
  include ManageIQClient

  respond_to :json

  after_action :verify_authorized


end