class AdsController < ApplicationController
  before_action :require_signed_in!, only: [:new, :create]
  
  def filter    
    @subcat = Subcat.includes(:ads).find(params[:subcat_id])
    @header_options = { head_link_text: [@subcat.category.title, @subcat.title],
       head_link_url: [subcat_ads_url(@subcat), subcat_ads_url(@subcat)]
      }
    @idio_options = @subcat.combined_option_classes
    
    @option_filters = params[:options].delete_if{ |k, v| !v.present? }
    
    
    @search_words = params[:search_words]
    @min_price = params[:min_price]
    @max_price = params[:max_price]
    @start_date = params[:start_date]
    @regions = params[:regions]

    @ads = @subcat.ads
    .includes(:integer_option_values)
    .includes(:string_option_values)
    .includes(:boolean_option_values)
    .includes(:date_option_values)
    .order(created_at: :desc)
    
    
    if @search_words.present?
      @ads = @ads.search_by_content(@search_words)
    end
    @ads = @ads.where("ads.price >= ? ", @min_price) if @min_price.present?
    @ads = @ads.where("ads.price <= ? ", @max_price) if @max_price.present?
    if @start_date.present?
      @ads = @ads.where("ads.start_date <= ? ", @start_date)
    end
    if @regions
      @regions = @regions.keys
      @ads = @ads.where("ads.region IN (?)", @regions)
    end
        
    @option_filters.each do |(id, value)|
      option_class = OptionClass.find(id) 
      case option_class.value_type
        when "IntegerOptionValue"
          @ads = @ads.where("options.option_class_id = ? AND integer_option_values.value >= ?", id, value)
          .references(:options, :integer_option_values)
        when "StringOptionValue"
          @ads = @ads.where("options.option_class_id = ? AND string_option_values.value = ?", id, value)
          .references(:options, :string_option_values)
        when "BooleanOptionValue"
          @ads = @ads.where("options.option_class_id = ? AND integer_option_values.value = ?", id, value)
          .references(:options, :boolean_option_values)
        when "DateOptionValue"
          @ads = @ads.where("options.option_class_id = ? AND date_option_values.value >= ?", id, value)
          .references(:options, :date_option_values)
      end
    end

    render :index
  end


  def index
    @subcat = Subcat.includes(:ads).find(params[:subcat_id])
    @idio_options = @subcat.combined_option_classes
    
    @ads = @subcat.ads.order(created_at: :desc)
    
    @header_options = { head_link_text: [@subcat.category.title, @subcat.title],
       head_link_url: [subcat_ads_url(@subcat), subcat_ads_url(@subcat)]
      }
      
    render :index
  end

  def show
    @ad = Ad.includes(:subcat).includes(:pictures).includes(:options).find(params[:id])
    @header_options = { head_link_text: [@ad.subcat.category.title, @ad.subcat.title, "listings"],
       head_link_url: [subcat_ads_url(@ad.subcat), subcat_ads_url(@ad.subcat), subcat_ad_url(@ad.subcat, @ad)]
      }
    @address = (@ad.location == "" || @ad.location.nil?) ?
     "36 Cooper Sq, New York, NY" : @ad.location
    
    render :show
  end

  def new
    @subcat_id = params[:subcat_id]
    @ad = Ad.new #I forget whether I need this declaration
    render :new
  end

  def create
    @ad = current_user.posted_ads.new(ad_params)
    @ad.entered_options = params[:entered_options]
    
    params[:pictures] && params[:pictures].reverse.each do |uploaded_img|
      @ad.pictures.new(image: uploaded_img) 
    end
    
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
    :region, :price, :subcat_id, :description, :pic1)
    # params.require(:ad).permit!
  end

  def option_params
    # params.require(:entered_options).permit!
  end

  # def option_params
  #   params.require(:ad).permit(:title, :start_date, :location,
  #   :region, :price, :subcat_id, :description, :options_data, :pic1)
  # end

end
