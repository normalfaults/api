class Project < ActiveRecord::Base
  acts_as_paranoid

  has_many :project_answers
  has_many :staff_projects
  has_many :staff, through: :staff_projects
  has_many :services, foreign_key: 'project_id', class_name: 'OrderItem'

  has_many :alerts, primary_key: 'id', foreign_key: 'project_id', class_name: 'Alert'
  has_many :latest_alerts, through: :services, class_name: 'Alert'

  has_many :approvals
  has_many :approvers, through: :approvals, source: :staff

  has_one :project_detail

  accepts_nested_attributes_for :project_answers

  scope :main_inclusions, -> { includes(:staff).includes(:project_answers).includes(:services) }

  def order_history
    history = Order.where(id: OrderItem.where(project_id: id).select(:order_id)).map do |order|
      order_json = order.as_json
      order_json[:item_count] = order.item_count_for_project_id(id)
      order_json
    end
    history
  end

  def domain
    'companyapp1.clouddealer.com/'
  end

  def url
    'http://companyapp1.clouddealer.com'
  end

  def state
    pc = problem_count
    case pc
    when 0
      '0 Problems'
    when 1
      '1 Problem'
    else
      "#{pc} Problems"
    end
  end

  def state_ok
    if problem_count == 0
      true
    else
      false
    end
  end

  def status
    2
  end

  def monthly_spend
    total = 0
    services.each do |service|
      total += service.setup_price + (service.hourly_price * 750) + service.monthly_price
    end
    total
  end

  def problem_count
    latest_alerts.not_status(:OK).count
  end

  def account_number
    785
  end

  def resources
    256
  end

  def resource_unit
    'MB'
  end

  def icon
    '/images/assets/projects/1.png'
  end

  def cpu
    8
  end

  def hdd
    '42 GB'
  end

  def ram
    '2 GB'
  end

  # Note: these ones are real bad because the names for these relations are different
  # in the ux. I am adding placeholders until I have time to change the ux.

  def users
    staff.as_json
  end

  # END OF STUBS
end
