class AddNotificationRelevantColumns < ActiveRecord::Migration
  def change
    add_column :users, :notifications_count, :integer
    rename_column :ads, :response_count, :responses_count
    rename_column :notifications, :message_id, :event_id
    rename_column :notifications, :viewed, :is_viewed
    add_column :notifications, :user_id, :integer
  end
end
