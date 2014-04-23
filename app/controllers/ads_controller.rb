class AdsController < ApplicationController
  before_action :require_signed_in!, only: [:new, :create]

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

  def create
    @ad = current_user.posted_ads.new(ad_params)

    if @ad.save
      flash[:notices] = ["Ad saved"]
      redirect_to subcat_ad_url(@ad.subcat, @ad)
    else
      flash.now[:errors] = @ad.errors.full_messages
      render :new
    end
  end

  def destroy

  end

  private
  def ad_params
    params.require(:ad).permit(:title, :start_date, :end_date, :location,
    :region, :price, :subcat_id, :description, :options_data)
  end

end
