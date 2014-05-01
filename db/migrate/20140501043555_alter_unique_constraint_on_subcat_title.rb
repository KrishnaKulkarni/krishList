class AlterUniqueConstraintOnSubcatTitle < ActiveRecord::Migration
  def change
    remove_index :subcats, :title
    add_index :subcats, :title
  end
end
