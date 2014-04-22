class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :title, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :location
      t.string :region, null: false
      t.integer :price, null: false
      t.integer :subcat_id, null: false
      t.integer :submitter_id, null: false
      t.text :description
      t.text :options_data
      t.integer :flag_count
      t.timestamps
    end

    add_index :ads, :title
    add_index :ads, :start_date
    add_index :ads, :end_date
    add_index :ads, :region
    add_index :ads, :price
    add_index :ads, :subcat_id
    add_index :ads, :submitter_id
    add_index :ads, :flag_count
  end
end
