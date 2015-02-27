class AddArchivedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :archived, :datetime
    add_index :projects, :archived
  end
end
