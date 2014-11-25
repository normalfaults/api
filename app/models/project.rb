class Project < ActiveRecord::Base
  acts_as_paranoid

  has_many :project_answers
  has_many :staff_projects
  has_many :staff, through: :staff_projects

  def self.create_with_answers(params)
    answers = params[:project_answers]
    params.delete :project_answers
    project = nil

    transaction do
      project = create!(params)
      if answers
        answers.each do |answer|
          project.project_answers.create!(answer)
        end
      end
    end

    project
  end
end
