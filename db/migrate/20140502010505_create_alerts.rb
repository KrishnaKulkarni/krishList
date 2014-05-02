class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.integer :subcat_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
    
    add_index :alerts, :subcat_id
    add_index :alerts, :user_id
  end
end
