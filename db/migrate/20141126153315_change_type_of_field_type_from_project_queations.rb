class ChangeTypeOfFieldTypeFromProjectQueations < ActiveRecord::Migration
  def change
    remove_column :project_questions, :field_type
    add_column :project_questions, :field_type, :integer, default: 0
  end
end
