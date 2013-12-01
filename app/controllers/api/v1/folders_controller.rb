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

  def set_permissions
    # TODO: remake
    @folder.permissions.destroy_all
    params[:folder][:ids].each do |id|
      @folder.allow_access_for User.find(id)
    end
    render json: @folder
  end

  def get_permissions
    # TODO: remake
    render json: @folder.permissions.map(&:user)
  end

  private

  def folder_params
    params.require(:folder).permit(:name, :password)
  end

end