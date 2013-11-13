class Api::V1::FoldersController < Api::V1::BaseController
  find :folder

  def show
    authorize @folder
    render json: @folder
  end

end