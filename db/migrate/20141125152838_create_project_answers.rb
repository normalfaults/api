class CreateProjectAnswers < ActiveRecord::Migration
  def change
    create_table :project_answers do |t|
      t.integer :project_id
      t.integer :project_question_id
      t.text :answer

      t.timestamps

      t.index :project_id
      t.index :project_question_id
    end
  end
end
