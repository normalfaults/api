class AlterProjectQuestionsRailsConventions < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        change_column :project_questions, :required, "boolean USING CAST(CASE required WHEN 'Y' THEN 't' ELSE 'f' END AS boolean)"
      end
      dir.down do
        change_column :project_questions, :required, "varchar(1) USING CAST(CASE required WHEN 't' THEN 'Y' ELSE 'N' END AS text)"
      end
    end

    add_column :project_questions, :project_id, :integer
    add_column :project_questions, :deleted_at, :datetime

    add_index :project_questions, :project_id
    add_index :project_questions, :deleted_at
  end
end
