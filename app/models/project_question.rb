# == Schema Information
#
# Table name: project_questions
#
#  id         :integer          not null, primary key
#  question   :string(255)
#  help_text  :string(255)
#  required   :boolean
#  created_at :datetime
#  updated_at :datetime
#  deleted_at :datetime
#  load_order :integer
#  options    :json
#  field_type :integer          default(0)
#
# Indexes
#
#  index_project_questions_on_deleted_at  (deleted_at)
#

class ProjectQuestion < ActiveRecord::Base
  acts_as_paranoid

  scope :ordered, -> { order('load_order') }

  has_many :project_answers, dependent: :destroy

  store_accessor :options

  enum field_type: [:check_box, :select_option, :text, :date]

  validates :question, presence: true
  validates :field_type, presence: true
end
