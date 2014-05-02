class CreateAlertDateOptions < ActiveRecord::Migration
  def change
    create_table :alert_date_options do |t|
      t.integer :alert_id, null: false
      t.integer :option_class_id, null: false
      t.date :value, null: false
      
      t.timestamps
    end
    
    add_index :alert_date_options, :alert_id
    add_index :alert_date_options, :option_class_id
    
  end
end
