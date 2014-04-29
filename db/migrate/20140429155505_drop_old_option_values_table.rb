class DropOldOptionValuesTable < ActiveRecord::Migration
  def change
    drop_table :option_values
  end
end
