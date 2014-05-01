class AddFeaturedOptionClassesToSubcats < ActiveRecord::Migration
  def change
    add_column :subcats, :featured_option_class_id1, :integer
    add_column :subcats, :featured_option_class_id2, :integer
  end
end
