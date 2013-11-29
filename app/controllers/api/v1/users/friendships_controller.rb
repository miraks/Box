class Api::V1::Users::FriendshipsController < Api::V1::BaseController
  find :user
  before_filter :authenticate_user!

  def create
    @friendship = current_user.become_friend_with @user
    if @friendship.persisted?
      render json: @friendship
    else
      render_error TextError.new('become_friend'), 500
    end
  end

  def destroy
    @friendship = current_user.stop_being_friend_of @user
    if @friendship.destroyed?
      render json: @friendship
    else
      render_error TextError.new('stop_being_friend'), 500
    end
  end

end