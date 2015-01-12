class ProjectAnswer < ActiveRecord::Base
  belongs_to :project
  belongs_to :project_question

  scope :without_orphans, -> { ProjectAnswer.where(project_question_id: ProjectQuestion.select(:id).uniq) }
  scope :including_questions, -> { includes(:project_question) }

  default_scope { without_orphans.including_questions }

  validates :project_question, presence: true
  validate :validate_project_question_id

  def answer=(answer)
    self[:answer] = answer.to_s
  end

  def answer
    case project_question.field_type
    when :date
      DateTime.parse(self[:answer])
    when :check_box
      self[:answer] == 'true'
    else
      self[:answer]
    end
  end

  private

  def validate_project_question_id
    errors.add(:project_question, 'Project question does not exist.') unless ProjectQuestion.exists?(project_question_id)
  end
end
