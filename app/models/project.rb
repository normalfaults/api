class Project < ActiveRecord::Base
  acts_as_paranoid

  has_many :project_answers
  has_many :staff_projects
  has_many :staff, through: :staff_projects

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
end
