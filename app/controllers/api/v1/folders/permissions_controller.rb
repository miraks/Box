class Api::V1::Folders::PermissionsController < Api::V1::BaseController

  find :folder
  find :user, in: [:folder_permission, :user] , only: :create

  def check
    render json: @folder, serializer: FolderPermissionSerializer
  end

  def create
    permission = @folder.allow_access_for @user
    render json: permission
  end

  def index
    render json: @folder.permissions, each_serializer: FolderPermissionWithUsersSerializer, root: 'folder_permission'
  end

  def destroy
    render json: @folder.permissions.find(params[:id]).destroy
  end

end