class Api::V1::Folders::PermissionsController < Api::V1::BaseController

  find :folder
  find :user, in: [:folder_permission, :user] , only: :create

  def check
    render json: @folder, serializer: FolderPermissionSerializer
  end

  def create
    @folder.allow_access_for @user
    render json: @folder
  end

  def index
    render json: @folder.permissions.includes(:users).map(&:user), serializer: FolderPermissionWithUserSerializer
  end

end