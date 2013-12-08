class Api::V1::Users::PermissionsController < Api::V1::BaseController
  before_filter :authenticate_user!
  find :user

  def index
    @permissions = @user.shared
    render json: @permissions
  end
end