class UsersController < ApplicationController
  find :user, only: [:show]
  before_filter :authenticate_user!, only: :show

  def index
    unless params[:query].present?
      @users = User.last(10)
    else
      @users = User.search params[:query]
    end
  end

  def show
  end

end
