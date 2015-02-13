class StaffSerializer < ApplicationSerializer
  attributes :id, :first_name, :last_name, :email, :phone, :role, :created_at, :updated_at

  has_many :orders
  has_many :staff_projects
  has_many :user_settings
  has_many :notifications
  has_many :projects
  has_one :cart
end
