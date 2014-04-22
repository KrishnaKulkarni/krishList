class AdsController < ApplicationController

  def index
    @subcat = Subcat.find(params[:subcat_id]).include(:ads)
    render :index
  end

  def show
    @ad = Ad.find(params[:id])
    render :show
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
