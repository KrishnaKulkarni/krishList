class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :ad_id, null: false
      t.integer :option_class_id, null: false
      t.references :option_value, polymorphic: true, null: false
      t.timestamps
    end
    
    add_index :options, :ad_id
    add_index :options, :option_class_id
    add_index :options, :option_value_id
  end
end
