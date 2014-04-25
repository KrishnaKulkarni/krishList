class RemoveRespondable < ActiveRecord::Migration
  def change
    remove_column :responses, :respondable_id
    remove_column :responses, :respondable_type
  end
end
