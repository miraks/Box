class Api::V1::Users::FriendshipsController < Api::V1::BaseController
  find :user
  before_filter :authenticate_user!

  def create
    @friendship = current_user.become_friend_with @user
    render json: { success: @friendship.persisted? }
  end

  def destroy
    @friendship = current_user.stop_being_friend_of @user
    render json: { success: @friendship.destroyed? }
  end

end