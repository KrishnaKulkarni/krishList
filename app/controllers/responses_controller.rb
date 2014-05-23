class ResponsesController < ApplicationController
  before_action :require_signed_in!

  def create
    ad = Ad.find(params[:ad_id])
    @response = ad.responses.new(
    response_params.merge({
      respondent_id: current_user.id
      }))

    if @response.save
      flash[:notices] = ["Your response has been sent!"]

      # MIGHT BE UNNECESSARY GIVEN javasctipt prefetching

      #send email to ad.submitter and to @response.author
    else
      flash[:errors] = @response.errors.full_messages
    end

    redirect_to subcat_ad_url(ad.subcat, ad)
  end

  def index
    @user = User.find(params[:user_id])
    if(require_current_user_matches!(@user))
      @ad = Ad.find(params[:ad_id]) #SHOULD I COMBINE THESE TWO QUERIES??
      @responses = @ad.responses
      render :index
    end
  end

  private
  def response_params
    params.require(:response).permit(:title, :body)
  end

end
