class ResponsesController < ApplicationController
  before_action :require_signed_in!

  def create
    ad = Ad.find(params[:ad_id])
    @response = ad.responses.new(
    response_params.merge({
      respondent_id: current_user.id,
      respondable_id: params[:ad_id],
      respondable_type: 'Ad'
      }))

    if @response.save
      flash[:notices] = ["Response saved"]
    else
      flash[:errors] = @response.errors.full_messages
    end

    redirect_to subcat_ad_url(ad.subcat, ad)
  end

  private
  def response_params
    params.require(:response).permit(:title, :body, :respondable_id,
     :respondable_type)
  end

end
