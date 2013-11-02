class Api::V1::UploadsController < Api::V1::BaseController
  find :folder, only: :create

  def create
    @upload = Upload.new user: current_user, file: params[:file], folder: @folder
    success = @upload.save
    render json: @upload, meta: { success: success }
  end

  def download
    # TODO: rewrite this to use only nginx in download
    @upload = Upload.find params[:upload_id] || params[:id]
    send_file @upload.file.path, filename: @upload.original_name
  end

end