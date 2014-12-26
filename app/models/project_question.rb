class ProjectQuestion < ActiveRecord::Base
  acts_as_paranoid

  scope :ordered, -> { order('load_order') }

  has_many :project_answers

  store_accessor :options

  enum field_type: [:check_box, :select_option, :text, :date]

  validates :question, presence: true
  validates :field_type, presence: true
end
