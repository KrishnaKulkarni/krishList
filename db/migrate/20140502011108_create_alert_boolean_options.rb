class CreateAlertBooleanOptions < ActiveRecord::Migration
  def change
    create_table :alert_boolean_options do |t|
      t.integer :alert_id, null: false
      t.integer :option_class_id, null: false
      t.boolean :value, default: false
      
      t.timestamps
    end
    
    add_index :alert_boolean_options, :alert_id
    add_index :alert_boolean_options, :option_class_id
    
  end
end
