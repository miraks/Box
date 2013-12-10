class Api::V1::UsersController < Api::V1::BaseController
  find :user, only: [:update]

  def index
    # TODO: Add pagination
    @users = User.last(100)
    render json: @users
  end

  def update
    @user.profile, @user.company_data = profile_params, company_params
    if @user.update_attributes user_params
      render json: @user
    else
      render_error ValidationError.new(@user), 403
    end
  end

  private

  def user_params
    allowed_params = %w{ name email profile_info avatar}
    allowed_params << :space_limit if current_user.try(:is_admin?)
    allowed_params << :company_info if current_user.try(:is_company?)
    params.require(:user).permit(allowed_params)
  end

  def company_params
    params.require(:user).require(:company_info)
  end

  def profile_params
    params.require(:user).require(:profile_info)
  end
end