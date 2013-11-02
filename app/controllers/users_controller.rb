class UsersController < ApplicationController
  find :user, only: [:show, :purchases]
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

  def purchases
    @purchases = @user.purchases
  end

end
