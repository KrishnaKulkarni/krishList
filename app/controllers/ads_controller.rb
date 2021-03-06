class AdsController < ApplicationController
  before_action :require_signed_in!, only: [:new, :create]
  
  def filter    
    @subcat = Subcat.includes(:ads, :featured_option_class1, :featured_option_class2)
    .find(params[:subcat_id])
    @header_options = { head_link_text: [@subcat.category.title, @subcat.title],
       head_link_url: [subcat_ads_url(@subcat), subcat_ads_url(@subcat)]
      }
    @idio_options = @subcat.combined_option_classes
    
   # @option_filters = params[:options] || {}
  #  @option_filters = params[:options].delete_if{ |k, v| !v.present? }
    @option_filters = params[:options] && params[:options].delete_if{ |k, v| !v.present? }
    
    create_alert(@subcat, current_user, @option_filters) if(params[:save_alert])
    
    @search_words = params[:search_words]
    @regions = params[:regions]

    # @ads = @subcat.ads
    # .includes(:options)
    # .includes(:integer_option_values)
    # .includes(:string_option_values)
    # .includes(:boolean_option_values)
    # .includes(:date_option_values)
    # .order(created_at: :desc)
        
    @ads = @subcat.ads
    .includes(:integer_options)
    .includes(:string_options)
    .includes(:boolean_options)
    .includes(:date_options)
    .order(created_at: :desc)
    
    if @search_words.present?
      @ads = @ads.search_by_content(@search_words)
    end

    if @regions
      @regions = @regions.keys
      @ads = @ads.where("ads.region IN (?)", @regions)
    end
        
    ids = []    
    @option_filters.present? && @option_filters.each_with_index do |(id, value), index|
      option_class = OptionClass.find(id) 
    
      case option_class.value_type
        when "IntegerOption"
           new_ids = @ads.where("integer_options.option_class_id = ? AND integer_options.value <= ?", id, value)
          .references(:integer_options).pluck(:id)
          #fail
        when "StringOption"
          new_ids = @ads.where("string_options.option_class_id = ? AND string_options.value = ?", id, value)
          .references(:string_options).pluck(:id)
          #fail
        when "BooleanOption"
          new_ids = @ads.where("boolean_options.option_class_id = ? AND boolean_options.value = ?", id, value)
          .references(:boolean_options).pluck(:id)
          #fail
        when "DateOption"
          new_ids = @ads.where("date_options.option_class_id = ? AND date_options.value <= ?", id, value)
          .references(:date_options).pluck(:id)
          #fail
      end
      if(index == 0)
        ids = new_ids
      else
        ids = ids & new_ids
      end
    end   
    
    ##THIS SHOULD BE ABLE TO BE SPED UP WITH BOOTSTRAPPING DATA
    # ids = []
    # @option_filters.present? && @option_filters.each_with_index do |(id, value), index|
    #   option_class = OptionClass.find(id) 
    #  #debugger
    #   case option_class.value_type
    #     when "IntegerOptionValue"
    #        new_ids = @ads.where("options.option_class_id = ? AND integer_option_values.value <= ?", id, value)
    #       .references(:options, :integer_option_values).pluck(:id)
    #       #fail
    #     when "StringOptionValue"
    #       new_ids = @ads.where("options.option_class_id = ? AND string_option_values.value = ?", id, value)
    #       .references(:options, :string_option_values).pluck(:id)
    #       #fail
    #     when "BooleanOptionValue"
    #       new_ids = @ads.where("options.option_class_id = ? AND boolean_option_values.value = ?", id, value).references(:options, :boolean_option_values).pluck(:id)
    #       #fail
    #     when "DateOptionValue"
    #       new_ids = @ads.where("options.option_class_id = ? AND date_option_values.value <= ?", id, value)
    #       .references(:options, :date_option_values).pluck(:id)
    #       #fail
    #   end
     # debugger
     #  if(index == 0)
    #     ids = new_ids
    #   else
    #     ids = ids & new_ids
    #   end
    # end
      
    #fail
    if(@option_filters.present?)
      @ads = ids.present? ? Ad.order(created_at: :desc).find(*ids) : []
    end

    render :index
  end


  def index
    @subcat = Subcat.includes(:ads, :featured_option_class1, :featured_option_class2)
    .find(params[:subcat_id])
    @idio_options = @subcat.combined_option_classes
    
    @option_filters = {}
    @ads = @subcat.ads.order(created_at: :desc)
    
    @header_options = { head_link_text: [@subcat.category.title, @subcat.title],
       head_link_url: [subcat_ads_url(@subcat), subcat_ads_url(@subcat)]
      }
      
    render :index
  end

  def show
    @ad = Ad.includes(:subcat).includes(:pictures)
    .includes(:boolean_options)
    .includes(:integer_options)
    .includes(:string_options)
    .includes(:date_options)
    .find(params[:id])
    @header_options = { head_link_text: [@ad.subcat.category.title, @ad.subcat.title, "listings"],
       head_link_url: [subcat_ads_url(@ad.subcat), subcat_ads_url(@ad.subcat), subcat_ad_url(@ad.subcat, @ad)]
      }
    @address = @ad.address
    
    render :show
  end

  def new
    @subcat_id = params[:subcat_id]
    @ad = Ad.new #I forget whether I need this declaration
    @header_options = { head_link_text: ["new ad"],
       head_link_url: [new_ad_url]
      }
    render :new
  end

  def create
    @ad = current_user.posted_ads.new(ad_params)
    @ad.entered_options = params[:entered_options]
    
    params[:pictures] && params[:pictures].reverse.each do |uploaded_img|
      @ad.pictures.new(image: uploaded_img) 
    end
    #fail
    if @ad.save
      flash[:notices] = ["Ad saved"]
      redirect_to subcat_ad_url(@ad.subcat, @ad)
    else
      @header_options = { head_link_text: ["new ad"],
         head_link_url: [new_ad_url]
        }
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
    params.require(:ad).permit(:title, :address,
    :region, :subcat_id, :description)
    # params.require(:ad).permit!
  end

  def create_alert(subcat, user, options_values)
    alert = user.alerts.for_subcat(subcat.id).new
    options_values.each do |(option_class_id, value)|
      option_class = OptionClass.find(option_class_id) 
      case option_class.value_type
        when "IntegerOption"
          alert.alert_integer_options.for_option(option_class_id).is_max.new(value: value)
        when "StringOption"
          alert.alert_string_options.for_option(option_class_id).new(value: value)
        when "BooleanOption"
          alert.alert_boolean_options.for_option(option_class_id).new(value: value)
        when "DateOption"
          alert.alert_date_options.for_option(option_class_id).is_max.new(value: value)
      end
    end
    
    if alert.save
      flash[:notices] ||= []
      flash[:notices] << "New Alert Saved!"
    else
      flash[:errors] ||= []
      flash.now[:errors].concat(alert.errors.full_messages)
    end
  end

end
