class Staff < ActiveRecord::Base
  self.table_name = :staff

  validates :phone, length: {maximum: 30}, allow_blank: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # Enabling others may require migrations to be made and run
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  enum role: [:user, :admin]
end
