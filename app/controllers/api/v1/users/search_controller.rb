class Api::V1::Users::SearchController < Api::V1::BaseController

  def index
    render json: User.search(params).results, each_serializer: UserSerializer, root: false
  end

end