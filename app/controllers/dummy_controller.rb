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
    json['marketplace_values'] = marketplace_values
    json['services'] = services
    json['html'] = marketplace_html
    json
  end

  def self.marketplace_html
    %w(marketplace header.html base.html marketplace.html marketplace-items.html left-sidebar.html search-marketplace.html service-box.html)
  end

  def self.project_new_json
    json = {}
    json['applications'] = applications
    json['bundles'] = bundles
    json['projects'] = projects
    json['header'] = header
    json['project_values'] = project_values
    json['solutions'] = solutions
    json['html'] = project_new_html
    json
  end

  def self.project_new_html
    %w(solution_search.html left-sidebar.html header.html new-project.html base.html new)
  end

  def self.project_json(id)
    json = {}
    json[id] = project(id)
    json['bundles'] = bundles
    json['applications'] = applications
    json['solutions'] = solutions
    json['header'] = header
    json['projects'] = projects
    json['html'] = project_html(id)
    json
  end

  def self.project_html(id)
    %w(left-sidebar.html solution_search.html service_box.html orders-table.html project.html base.html header.html ) << id
  end

  def self.service_json(id)
    json = {}
    json['applications'] = applications
    json['header'] = header
    json['projects'] = projects
    json['bundles'] = bundles
    json['marketplace_values'] = marketplace_values
    json[id] = service(id)
    json['solutions'] = solutions
    json['html'] = service_html(id)
    json
  end

  def self.service_html(id)
    %w(header.html service.html base.html left-sidebar.html search-marketplace.html) << id
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
    (1..15).each { |id| data << JSON.parse(File.read(Rails.root.to_s + "/config/data/services/#{id}.json")) }
    data
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
