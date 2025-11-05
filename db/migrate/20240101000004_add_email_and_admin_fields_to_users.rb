class AddEmailAndAdminFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :display_name, :string
    add_column :users, :email, :string
    add_column :users, :is_admin, :boolean, default: false
    
    add_index :users, :email, unique: true
  end
end

