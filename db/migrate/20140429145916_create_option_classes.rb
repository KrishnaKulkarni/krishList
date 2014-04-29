class CreateOptionClasses < ActiveRecord::Migration
  def change
    create_table :option_classes do |t|
      t.string :title, null: false
      t.references :option_classable, polymorphic: true, null: false
      t.string :input_type, null: false
      t.string :value_type, null: false
      t.boolean :is_mandatory, default: false
      t.timestamps
    end
    
      add_index :option_classes, :title
      add_index :option_classes, :option_classable_id
      add_index :option_classes, :value_type
  end
end
