class CreateBooleanOptions < ActiveRecord::Migration
  def change
    create_table :boolean_options do |t|
      t.integer :ad_id, null: false
      t.integer :option_class_id, null: false
      t.boolean :value
      t.timestamps
    end
    
    add_index :boolean_options, :ad_id
    add_index :boolean_options, :option_class_id
  end
end
