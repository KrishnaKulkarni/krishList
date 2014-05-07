class CreateIntegerOptions < ActiveRecord::Migration
  def change
    create_table :integer_options do |t|
      t.integer :ad_id, null: false
      t.integer :option_class_id, null: false
      t.integer :value, null: false
      t.timestamps
    end
    
    add_index :integer_options, :ad_id
    add_index :integer_options, :option_class_id
  end
end
