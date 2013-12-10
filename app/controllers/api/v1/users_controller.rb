class Api::V1::UsersController < Api::V1::BaseController
  find :user, only: [:update]

  def index
    # TODO: Add pagination
    @users = User.last(100)
    render json: @users
  end

  def update
    if @user.update_attributes user_params
      render json: @user
    else
      render_error ValidationError.new(@user), 403
    end
  end

  private

  def user_params
    allowed_params = [:name, :email, :avatar, { profile: User::PROFILE_FIELDS }]
    allowed_params << :space_limit if current_user.try(:is_admin?)
    allowed_params << { company_data: User::COMPANY_DATA_FIELDS } if current_user.try(:is_company?)
    params.require(:user).permit(allowed_params)
  end
end