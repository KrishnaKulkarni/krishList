class AdsController < ApplicationController

  def index
    @subcat = Subcat.includes(:ads).find(params[:subcat_id])
    render :index
  end

  def show
    @ad = Ad.find(params[:id])
    render :show
  end

  def new
    @subcat_id = params[:subcat_id]
    @ad = Ad.new #I forget whether I need this declaration
    render :new
  end

  def destroy

  end

  private
  def ad_params
    params.require(:ad).permit(:title, :start_date, :end_date, :location,
    :region, :price, :subcat_id, :submitter_id, :flag_count, :description,
    :options_data)
  end

end
