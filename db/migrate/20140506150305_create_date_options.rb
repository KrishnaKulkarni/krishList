class CreateDateOptions < ActiveRecord::Migration
  def change
    create_table :date_options do |t|
      t.integer :ad_id, null: false
      t.integer :option_class_id, null: false
      t.date :value, null: false
      t.timestamps
    end
    
    add_index :date_options, :ad_id
    add_index :date_options, :option_class_id
  end
end
