class AlterProjectIdAndOrderFromProjectQuestions < ActiveRecord::Migration
  def change
    remove_column :project_questions, :project_id
    add_column :project_questions, :load_order, :integer
  end
end
