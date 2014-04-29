class CreateBooleanOptionValues < ActiveRecord::Migration
  def change
    create_table :boolean_option_values do |t|
      t.boolean :value, null: false
      t.timestamps
    end
    
  end
end
