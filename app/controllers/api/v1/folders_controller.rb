class Api::V1::FoldersController < Api::V1::BaseController
  find :folder

  def show
    authorize @folder, args: params[:password]
    render json: @folder
  end

  def update
    @folder.update_attributes! folder_params
    render json: @folder
  end

  def permission
    render json: @folder, serializer: FolderPermissionSerializer
  end

  private

  def folder_params
    params.require(:folder).permit(:name, :password)
  end

end