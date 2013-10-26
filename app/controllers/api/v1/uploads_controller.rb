class Api::V1::UploadsController < Api::V1::BaseController
  include FolderFinder

  before_filter :find_folder

  def create
    current_user = User.last # TODO: remove when current_user will be available
    @upload = Upload.new user: current_user, file: params[:file], folder: @folder
    success = @upload.save
    render json: @upload, meta: { success: success }
  end

end