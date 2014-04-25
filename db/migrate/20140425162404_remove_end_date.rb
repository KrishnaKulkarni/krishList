class RemoveEndDate < ActiveRecord::Migration
  def change
    remove_column  :ads, :end_date
  end
end
