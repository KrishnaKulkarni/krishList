class TrimAdModel < ActiveRecord::Migration
  def change
    remove_column :ads, :start_date
 
    remove_column :ads, :price
    remove_column :ads, :options_data
    remove_column :ads, :flag_count
    remove_column :ads, :pic1_file_name
    remove_column :ads, :pic1_content_type
    remove_column :ads, :pic1_file_size
    remove_column :ads, :pic1_updated_at
    
    rename_column :ads, :location, :address
  end
end
