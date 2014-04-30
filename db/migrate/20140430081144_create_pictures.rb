class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :url
      t.integer :ad_id, null: false

      t.timestamps
    end
    add_index :pictures, :ad_id
  end
end
