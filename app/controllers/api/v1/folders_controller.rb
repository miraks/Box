class Api::V1::FoldersController < Api::V1::BaseController
  find :folder

  def show
    authorize @folder
    render json: @folder
  end

  def update
    @folder.update_attributes! folder_params
    render json: @folder
  end

  private

  def folder_params
    params.require(:folder).permit(:name, :password)
  end

end