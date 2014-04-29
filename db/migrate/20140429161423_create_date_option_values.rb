class CreateDateOptionValues < ActiveRecord::Migration
  def change
    create_table :date_option_values do |t|
      t.date :value, null: false
      t.timestamps
    end
    
  end
end
