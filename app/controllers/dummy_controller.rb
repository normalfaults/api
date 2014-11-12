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

  def self.manage_json
    json = {}
    json['solutions'] = solutions
    json['projects'] = projects
    json['applications'] = applications
    json['bundles'] = bundles
    json['header'] = header
    json['manage_values'] = manage_values
    json['recent_orders'] = recent_orders
    json['recent_users'] = recent_users
    json['alerts'] = alerts
    json['html'] = manage_html
    json
  end

  def self.manage_html
    %w(manage header.html base.html manage.html orders-table.html left-sidebar.html solution-search.html solution-statistic.html problem-alerts)
  end

  def self.marketplace_json
    json = {}
    json['header'] = header
    json['projects'] = projects
    json['bundles'] = bundles
    json['applications'] = applications
    json['solutions'] = solutions
    json['manage_values'] = manage_values
    json['services'] = services
    json['html'] = marketplace_html
    json
  end

  def self.marketplace_html
    %w(marketplace header.html base.html marketplace.html marketplace-items.html left-sidebar.html search-marketplace.html service-box.html)
  end

  def self.recent_solutions
    projects[1]['services']
  end

  def self.recent_users
    projects[1]['users']
  end

  def self.recent_orders
    projects[1]['orderHistory']
  end

  def self.solutions
    data = []
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/solutions/1.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/solutions/2.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/solutions/3.json'))
  end

  def self.solution(id)
    JSON.parse(File.read(Rails.root.to_s + "/config/data/solutions/#{id}.json"))
  end

  def self.projects
    data = []
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/projects/1.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/projects/2.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/projects/3.json'))
  end

  def self.project(id)
    JSON.parse(File.read(Rails.root.to_s + "/config/data/projects/#{id}.json"))
  end

  def self.services
    data = []
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/services/1.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/services/2.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/services/3.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/services/4.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/services/5.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/services/6.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/services/7.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/services/8.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/services/9.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/services/10.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/services/11.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/services/12.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/services/13.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/services/14.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/services/15.json'))
  end

  def self.service(id)
    JSON.parse(File.read(Rails.root.to_s + "/config/data/services/#{id}.json"))
  end

  def self.applications
    data = []
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/applications/1.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/applications/2.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/applications/3.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/applications/4.json'))
  end

  def self.application(id)
    JSON.parse(File.read(Rails.root.to_s + "/config/data/applications/#{id}.json"))
  end

  def self.bundles
    data = []
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/bundles/1.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/bundles/2.json'))
    data << JSON.parse(File.read(Rails.root.to_s + '/config/data/bundles/3.json'))
  end

  def self.bundle(id)
    JSON.parse(File.read(Rails.root.to_s + "/config/data/bundles/#{id}.json"))
  end

  def self.header
    JSON.parse(File.read(Rails.root.to_s + '/config/data/header.json'))
  end

  def self.project_values
    JSON.parse(File.read(Rails.root.to_s + '/config/data/new-project.json'))
  end

  def self.manage_values
    JSON.parse(File.read(Rails.root.to_s + '/config/data/manage.json'))
  end

  def self.marketplace_values
    JSON.parse(File.read(Rails.root.to_s + '/config/data/marketplace.json'))
  end

  def self.alerts
    JSON.parse(File.read(Rails.root.to_s + '/config/data/alerts.json'))
  end

  def self.alert_popup
    JSON.parse(File.read(Rails.root.to_s + '/config/data/alert-popup.json'))
  end
end
