class CreateStringOptionValues < ActiveRecord::Migration
  def change
    create_table :string_option_values do |t|
      t.string :value, null: false
      t.timestamps
    end
    
  end
end
