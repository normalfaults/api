class Provision < ActiveRecord::Base
  extend ManageIQClient

  acts_as_paranoid

  @@client = nil

  def initialize
    if ENV['MANAGEIQ_HOST']
      ManageIQClient.host = ENV['MANAGEIQ_HOST']
      ManageIQClient.verify_ssl = ENV['MANAGEIQ_SSL'].nil? ? true : !ENV['MANAGEIQ_SSL'].to_i.zero?
      if ENV['MANAGEIQ_USER'] && ENV['MANAGEIQ_PASS']
        @@client = ManageIQClient.credentials = { user: ENV['MANAGEIQ_USER'], password: ENV['MANAGEIQ_PASS'] }
      end
    end
  end

  def self.client
    miq = { host: ENV['MANAGEIQ_HOST'], verify_ssl: ENV['MANAGEIQ_SSL'], user: ENV['MANAGEIQ_USER'], password: ENV['MANAGEIQ_PASS'] }
  end

  #def vm
  #  ManageIQClient::VirtualMachine.list
  #end
end