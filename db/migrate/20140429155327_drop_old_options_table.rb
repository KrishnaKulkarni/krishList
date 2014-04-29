class DropOldOptionsTable < ActiveRecord::Migration
  def change
    drop_table :options
  end
end
