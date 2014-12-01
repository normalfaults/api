class Staff < ActiveRecord::Base
  self.table_name = :staff

  acts_as_paranoid

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
end
