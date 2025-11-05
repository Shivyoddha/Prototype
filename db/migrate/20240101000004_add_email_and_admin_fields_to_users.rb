class AddEmailAndAdminFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:users, :display_name)
      add_column :users, :display_name, :string
    end
    
    unless column_exists?(:users, :email)
      add_column :users, :email, :string
    end
    
    unless column_exists?(:users, :is_admin)
      add_column :users, :is_admin, :boolean, default: false
    end
    
    unless index_exists?(:users, :email)
      add_index :users, :email, unique: true
    end
  end
end

