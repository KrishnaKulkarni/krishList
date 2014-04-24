class AdsAddRespCt < ActiveRecord::Migration
  def change
    add_column :ads, :response_count, :integer
  end
end
