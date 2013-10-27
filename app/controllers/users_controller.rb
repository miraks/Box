class UsersController < ApplicationController
  include UserFinder

  before_filter :find_user, only: [:show]
  before_filter :authenticate_user!, only: :show

  def index
    unless params[:query].present?
      @users = User.all
    else 
      @users = User.search params[:query]
    end 
  end

  def show
    @user = User.find params[:id]
  end

end
