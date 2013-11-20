class UsersController < ApplicationController
  find :user, only: [:show]
  before_filter :authenticate_user!, only: :show

  def index
  end

  def show
  end

end
