class Order < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :project
  belongs_to :product
  belongs_to :cloud
  belongs_to :staff

  store_accessor :options
end
