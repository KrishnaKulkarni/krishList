class CreateAlertIntegerOptions < ActiveRecord::Migration
  def change
    create_table :alert_integer_options do |t|
      t.integer :alert_id, null: false
      t.integer :option_class_id, null: false
      t.integer :value, null: false
      
      t.timestamps
    end
    
    add_index :alert_integer_options, :alert_id
    add_index :alert_integer_options, :option_class_id
    
  end
end
