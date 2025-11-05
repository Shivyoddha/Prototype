class CreateDocBs < ActiveRecord::Migration[7.0]
  def change
    create_table :doc_bs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :eq_id, null: false
      t.string :name, null: false
      t.decimal :cost, null: false, precision: 10, scale: 2
      t.string :head, null: false
      t.text :proceedings, null: false
      
      # U fields
      t.datetime :u_date
      t.text :u_remarks
      
      # P fields
      t.datetime :p_date
      t.text :p_remarks
      
      # Q fields
      t.datetime :q_date
      t.text :q_remarks
      
      # R fields
      t.datetime :r_date
      t.text :r_remarks
      
      # S fields
      t.datetime :s_date
      t.text :s_remarks
      
      t.integer :status, default: 0

      t.timestamps
    end
  end
end

