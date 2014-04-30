class CategoriesController < ApplicationController

  def show
    @category = Category.includes(:subcats).find(params[:id])
      # render json: @category
      render :show, layout: false
  end

end
