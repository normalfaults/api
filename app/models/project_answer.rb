class ProjectAnswer < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :project
  belongs_to :project_question

  validates :project, presence: true
  validate :validate_project_id

  validates :project_question, presence: true
  validate :validate_project_question_id

  private

  def validate_project_id
    errors.add(:project, 'Project does not exist.') unless Project.exists?(project_id)
  end

  def validate_project_question_id
    errors.add(:project_question, 'Project question does not exist.') unless ProjectQuestion.exists?(project_question_id)
  end
end
