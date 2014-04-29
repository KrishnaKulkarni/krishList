class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
    
      t.string :title, null: false
      t.string :input_type, null: false
      t.string :datatype, null: false
      t.references :optionable, polymorphic: true, null: false
      t.boolean :is_mandatory, null: false
      t.timestamps
    end
    
    add_index :options, :title
    add_index :options, :optionable_id
  end
end
