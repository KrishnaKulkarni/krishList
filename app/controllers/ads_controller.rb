class AdsController < ApplicationController
  before_action :require_signed_in!, only: [:new, :create]

  def filter
    @subcat = Subcat.includes(:ads).find(params[:subcat_id])
    @min_price = params[:min_price]
    @max_price = params[:max_price]
    @start_date = params[:start_date]

    min_price = params[:min_price] == "" ? 0 : params[:min_price].to_i
    max_price = params[:max_price] == "" ? "10000000" : params[:max_price].to_i


    @ads = @subcat.ads
    .where("ads.price >= ? AND ads.price <= ?", min_price, max_price)
    .where("ads.start_date <= ?", @start_date)

    render :index
  end


  def index
    @subcat = Subcat.includes(:ads).find(params[:subcat_id])
    @ads = @subcat.ads
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
    @ad = Ad.find(params[:id])
    submitter = @ad.submitter
    if(require_current_user_matches!(submitter))
      @ad.destroy!
      flash[:notices] = ["Ad destroyed"]
      redirect_to user_ads_url(submitter)
    elsif(require_admin!)
      @ad.destroy!
      flash[:notices] = ["Ad destroyed"]
      redirect_to root_url
    end
  end

  def repost
    @ad = Ad.find(params[:id])
    @subcat_id = @ad.subcat_id
    submitter = @ad.submitter
    if(require_current_user_matches!(submitter))
      render :new
    end
  end

  private
  def ad_params
    params.require(:ad).permit(:title, :start_date, :location,
    :region, :price, :subcat_id, :description, :options_data)
  end

end
