class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :notifiable, polymorphic: true, null: false
      t.integer :message_id, null: false
      t.boolean :viewed, default: false
      t.timestamps
    end

    add_index :notifications, :notifiable_id
    add_index :notifications, :viewed
  end
end
