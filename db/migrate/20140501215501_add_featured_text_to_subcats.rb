class AddFeaturedTextToSubcats < ActiveRecord::Migration
  def change
    add_column :subcats, :featured_text, :string
  end
end
