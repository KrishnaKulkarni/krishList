class AddIsLowerBoundToAlertDateOptions < ActiveRecord::Migration
  def change
    add_column :alert_date_options, :is_lower_bound, :boolean
  end
end
