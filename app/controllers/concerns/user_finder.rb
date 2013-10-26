module UserFinder
  extend ActiveSupport::Concern

  def find_user
    @user = User.find params[:user_id] || params[:id]
  end
end