class CreateStringOptions < ActiveRecord::Migration
  def change
    create_table :string_options do |t|
      t.integer :ad_id, null: false
      t.integer :option_class_id, null: false
      t.string :value, null: false
      t.timestamps
    end
    
    add_index :string_options, :ad_id
    add_index :string_options, :option_class_id
  end
end
