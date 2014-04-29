class CreateOptionValues < ActiveRecord::Migration
  def change
    create_table :option_values do |t|
      t.integer :ad_id, null: false
      t.integer :option_id, null: false
      t.string :value, null: false
      
      t.timestamps
    end
    
    add_index :option_values, :ad_id
    add_index :option_values, :option_id
  end
end
