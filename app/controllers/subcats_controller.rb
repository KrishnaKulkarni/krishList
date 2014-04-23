class SubcatsController < ApplicationController
  # Category Model
  # Subcat Model
  # assoc: Category has_many subcats
  def index
    @categories = Category.includes(:subcats).all
    render :index
  end

end
