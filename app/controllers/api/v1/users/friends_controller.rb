class Api::V1::Users::FriendsController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    @friends = current_user.friends
    render json: @friends, each_serializer: FriendSerializer
  end

end