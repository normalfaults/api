class MocksController < ApplicationController
  respond_to :json

  def applications
    data = (1..4).map { |id| JSON.parse(File.read(File.join(Rails.root, 'config', 'data', 'applications', "#{id}.json"))) }
    respond_with data
  end

  def application
    respond_with File.read(File.join(Rails.root, 'config', 'data', 'applications', "#{params[:id]}.json"))
  end

  def bundles
    data = (1..3).map { |id| JSON.parse(File.read(File.join(Rails.root, 'config', 'data', 'bundles', "#{id}.json"))) }
    respond_with data
  end

  def bundle
    respond_with File.read(File.join(Rails.root, 'config', 'data', 'bundles', "#{params[:id]}.json"))
  end

  def services
    data = (1..15).map { |id| JSON.parse(File.read(File.join(Rails.root, 'config', 'data', 'services', "#{id}.json"))) }
    respond_with data
  end

  def service
    respond_with File.read(File.join(Rails.root, 'config', 'data', 'services', "#{params[:id]}.json"))
  end

  def solutions
    data = (1..3).map { |id| JSON.parse(File.read(File.join(Rails.root, 'config', 'data', 'solutions', "#{id}.json"))) }
    respond_with data
  end

  def solution
    respond_with File.read(File.join(Rails.root, 'config', 'data', 'solutions', "#{params[:id]}.json"))
  end

  def alert_popup
    respond_with File.read(File.join(Rails.root, 'config', 'data', 'alert-popup.json'))
  end

  def alerts
    respond_with File.read(File.join(Rails.root, 'config', 'data', 'alerts.json'))
  end

  def header
    respond_with File.read(File.join(Rails.root, 'config', 'data', 'header.json'))
  end

  def manage
    respond_with File.read(File.join(Rails.root, 'config', 'data', 'manage.json'))
  end

  def marketplace
    respond_with File.read(File.join(Rails.root, 'config', 'data', 'marketplace.json'))
  end

  def new_project
    respond_with File.read(File.join(Rails.root, 'config', 'data', 'new-project.json'))
  end
end
