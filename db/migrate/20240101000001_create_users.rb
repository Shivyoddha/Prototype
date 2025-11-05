class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :user_id, null: false, unique: true
      t.string :user_name, null: false, unique: true
      t.string :password_digest, null: false
      t.string :display_name
      t.string :email
      t.boolean :is_admin, default: false

      t.timestamps
    end

    add_index :users, :user_name, unique: true
    add_index :users, :email, unique: true
  end
end

