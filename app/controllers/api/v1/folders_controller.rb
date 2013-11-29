class Api::V1::FoldersController < Api::V1::BaseController
  find :folder

  def show
    authorize @folder, args: params[:password]
    render json: @folder
  end

  def update
    if @folder.update_attributes folder_params
      render json: @folder
    else
      render_error ValidationError.new(@folder), 403
    end
  end

  def permission
    render json: @folder, serializer: FolderPermissionSerializer
  end

  private

  def folder_params
    params.require(:folder).permit(:name, :password)
  end

end