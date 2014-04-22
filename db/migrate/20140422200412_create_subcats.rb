class CreateSubcats < ActiveRecord::Migration
  def change
    create_table :subcats do |t|
      t.string :title, null: false
      t.integer :category_id, null: false

      t.timestamps
    end

    add_index :subcats, :title, unique: true
    add_index :subcats, :category_id
  end
end
