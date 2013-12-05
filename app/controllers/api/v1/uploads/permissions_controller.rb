class Api::V1::Uploads::PermissionsController < Api::V1::BaseController

  find :upload
  find :user, in: [:upload_permission, :user] , only: :create

  def check
    render json: @upload, serializer: UploadPermissionSerializer
  end

  def create
    permission = @upload.allow_access_for @user
    render json: permission
  end

  def index
    render json: @upload.permissions, each_serializer: UploadPermissionWithUsersSerializer, root: 'upload_permission'
  end

end