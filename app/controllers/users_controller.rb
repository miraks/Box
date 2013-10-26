class UsersController < ApplicationController
  include UserFinder

  before_filter :find_user, only: [:show]
  before_filter :authenticate_user!, only: :show

  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
  end

end
