class DummyController < ApplicationController
  def self.dashboard_json
    json = {}
    json['header'] = header
    json['projects'] = projects
    json['bundles'] = bundles
    json['applications'] = applications
    json['solutions'] = solutions
    json['alerts'] = alerts
    json['alert_popup'] = alert_popup
    json['html'] = dashboard_html
    json
  end

  def self.dashboard_html
    %w(dashboard header.html base.html dashboard.html left-sidebar.html solution-search.html problem-alerts.html)
  end

  def self.header
    JSON.parse(File.read(Rails.root.to_s + '/config/data/header.json'))
  end

  def self.projects
    data = []
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/projects/1.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/projects/2.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/projects/3.json'))
  end

  def self.bundles
    data = []
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/bundles/1.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/bundles/2.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/bundles/3.json'))
  end

  def self.applications
    data = []
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/applications/1.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/applications/2.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/applications/3.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/applications/4.json'))
  end

  def self.services
    data = []
    (1..15).each | i |
      data << JSON.parse(File.read(Rails.root.to_s + "/config/data/services/#{i}.json"))
  end

  def self.solutions
    data = []
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/solutions/1.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/solutions/2.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/solutions/3.json'))
  end

  def self.alert_popup
    JSON.parse(File.read(Rails.root.to_s + '/config/data/alert-popup.json'))
  end

  def self.alerts
    JSON.parse(File.read(Rails.root.to_s + '/config/data/alerts.json'))
  end

  def self.manage
    JSON.parse(File.read(Rails.root.to_s + '/config/data/manage.json'))
  end

  def self.marketplace
    JSON.parse(File.read(Rails.root.to_s + '/config/data/marketplace.json'))
  end

  def self.new_project
    JSON.parse(File.read(Rails.root.to_s + '/config/data/new-project.json'))
  end
end
