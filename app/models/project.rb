class Project < ActiveRecord::Base
  acts_as_paranoid

  has_many :project_answers
  has_many :staff_projects
  has_many :staff, through: :staff_projects
  has_many :orders

  has_many :approvals
  has_many :approvers, through: :approvals, source: :staff

  has_one :project_detail

  scope :main_inclusions, -> { includes(:staff).includes(:project_answers).includes(:orders) }

  def self.create_with_answers(attributes)
    answers = attributes[:project_answers]
    attributes.delete :project_answers
    project = nil

    transaction do
      project = create!(attributes)
      project.insert_answers!(answers)
    end

    project
  end

  def insert_answers!(answers)
    answers ||= []
    answers.each do |answer|
      project_answers.create!(answer)
    end
  end

  def update_with_answers!(attributes)
    answers = attributes[:project_answers]
    attributes.delete :project_answers

    self.class.transaction do
      update_attributes(attributes)
      project_answers.destroy_all
      insert_answers!(answers)
    end
  end

  # NOTE: Theses are just stubs and should be replace with real stuff
  # START OF STUBS
  def order_history
    orders.as_json
  end

  def services
    []
  end

  def domain
    'companyapp1.clouddealer.com/'
  end

  def url
    'http://companyapp1.clouddealer.com'
  end

  def state
    '2 Problems'
  end

  def state_ok
    false
  end

  def problem_count
    0
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

  def status
    2
  end

  # Note: these ones are real bad because the names for these relations are different
  # in the ux. I am adding placeholders until I have time to change the ux.

  def users
    staff.as_json
  end

  # END OF STUBS
end
