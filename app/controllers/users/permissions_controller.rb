class Users::PermissionsController < ApplicationController
  before_filter :authenticate_user!
  find :user

  def index
  end
end