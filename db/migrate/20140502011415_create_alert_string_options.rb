class CreateAlertStringOptions < ActiveRecord::Migration
  def change
    create_table :alert_string_options do |t|
      t.integer :alert_id, null: false
      t.integer :option_class_id, null: false
      t.string :value, null: false
      
      t.timestamps
    end
    
    add_index :alert_string_options, :alert_id
    add_index :alert_string_options, :option_class_id
    
  end
end
