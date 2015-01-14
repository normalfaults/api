class AddAuthenticationTokenToStaff < ActiveRecord::Migration
  def change
    add_column :staff, :authentication_token, :string
    add_index :staff, :authentication_token
  end
end
