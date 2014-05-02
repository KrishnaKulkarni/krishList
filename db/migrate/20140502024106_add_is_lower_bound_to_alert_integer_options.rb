class AddIsLowerBoundToAlertIntegerOptions < ActiveRecord::Migration
  def change
    add_column :alert_integer_options, :is_lower_bound, :boolean
  end
end
