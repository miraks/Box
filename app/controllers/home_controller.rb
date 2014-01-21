class HomeController < ApplicationController
  def index
    if logged_in?
      redirect_to user_url(current_user)
    else
      render layout: false
    end
  end
end
