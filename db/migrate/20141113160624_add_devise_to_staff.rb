class AddDeviseToStaff < ActiveRecord::Migration
  def change
    remove_column :staff, :password
    add_column :staff, :encrypted_password, :string, null: false, default: ''

    ## Recoverable
    add_column :staff, :reset_password_token, :string
    add_column :staff, :reset_password_sent_at, :datetime

    ## Rememberable
    add_column :staff, :remember_created_at, :datetime

    ## Trackable
    add_column :staff, :sign_in_count, :integer, default: 0, null: false
    add_column :staff, :current_sign_in_at, :datetime
    add_column :staff, :last_sign_in_at, :datetime
    add_column :staff, :current_sign_in_ip, :inet
    add_column :staff, :last_sign_in_ip, :inet

    add_index :staff, :email, unique: true
    add_index :staff, :reset_password_token, unique: true
  end
end
