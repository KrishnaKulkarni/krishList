class StaticPagesController < ApplicationController

  def root
    #render :root
    redirect_to subcats_url
  end

end
