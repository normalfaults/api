class CreateAdminSettings < ActiveRecord::Migration
  def change
    create_table :admin_settings do |t|
      t.string :name, limit: 255
    end
  end
end
