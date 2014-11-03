class CreateProjectQuestions < ActiveRecord::Migration
  def change
    create_table :project_questions do |t|
      t.string :question, limit: 255
      t.string :field_type, limit: 100
      t.string :help_text, limit: 255
      t.text :options
      t.string :required, limit: 1
      t.timestamps
    end
  end
end
