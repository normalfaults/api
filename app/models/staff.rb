# == Schema Information
#
# Table name: staff
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)
#  phone                  :string(30)
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  role                   :integer          default(0)
#  deleted_at             :datetime
#  authentication_token   :string(255)
#
# Indexes
#
#  index_staff_on_authentication_token  (authentication_token) UNIQUE
#  index_staff_on_deleted_at            (deleted_at)
#  index_staff_on_email                 (email) UNIQUE
#  index_staff_on_reset_password_token  (reset_password_token) UNIQUE
#

class Staff < ActiveRecord::Base
  include TokenAuthenticable
  include PgSearch

  self.table_name = :staff

  acts_as_paranoid

  has_many :orders
  has_many :user_settings
  has_many :staff_projects
  has_many :notifications
  has_many :projects, through: :staff_projects

  has_one :cart

  validates :phone, length: { maximum: 30 }, allow_blank: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable
  # Enabling others may require migrations to be made and run
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  enum role: [:user, :admin]

  pg_search_scope :search, against: [:first_name, :last_name, :email], using: { tsearch: { prefix: true } }

  def gravatar
    '3fc88b95c85e43f157cb1ffd0e37e832'
  end
end
