class ChangeTypeOfOptionsFromProjectQuestions < ActiveRecord::Migration
  def change
    remove_column :project_questions, :options
    add_column :project_questions, :options, :json
  end
end
