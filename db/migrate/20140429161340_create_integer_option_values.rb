class CreateIntegerOptionValues < ActiveRecord::Migration
  def change
    create_table :integer_option_values do |t|
      t.integer :value, null: false
      t.timestamps
    end
    
  end
end
