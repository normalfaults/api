class ProjectAnswer < ActiveRecord::Base
  belongs_to :project
  belongs_to :project_question

  scope :without_orphans, -> { ProjectAnswer.where(project_question_id: ProjectQuestion.select(:id).uniq) }
  scope :including_questions, -> { includes(:project_question) }

  default_scope { without_orphans.including_questions }

  validates :project, presence: true
  validate :validate_project_id

  validates :project_question, presence: true
  validate :validate_project_question_id

  def answer=(answer)
    write_attribute(:answer, answer.to_s)
  end

  def answer
    case project_question.field_type
      when :date
        DateTime.parse(read_attribute(:answer))
      when :check_box
        read_attribute(:answer) == 'true'
      else
        read_attribute(:answer)
    end
  end

  private

  def validate_project_id
    errors.add(:project, 'Project does not exist.') unless Project.exists?(project_id)
  end

  def validate_project_question_id
    errors.add(:project_question, 'Project question does not exist.') unless ProjectQuestion.exists?(project_question_id)
  end
end
