class AddAdIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :ad_id, :integer
  end
end
