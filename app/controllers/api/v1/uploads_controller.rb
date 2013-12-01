class Api::V1::UploadsController < Api::V1::BaseController
  find :folder, only: [:create]
  find :upload, only: [:update, :download, :permission, :get_permissions, :set_permissions]
  find :folder, in: :upload, only: [:move, :copy]
  find :uploads, in: :upload, only: [:move, :copy]

  def create
    @upload = Upload.new user: current_user, file: params[:file], folder: @folder
    if @upload.save
      render json: @upload
    else
      render_error ValidationError.new(@upload), 403
    end
  end

  def update
    if @upload.update_attributes upload_params
      render json: @upload
    else
      render_error ValidationError.new(@upload), 403
    end
  end

  def download
    authorize @upload, args: params[:password]
    render json: @upload, serializer: UploadUrlSerializer
  end

  def permission
    render json: @upload, serializer: UploadPermissionSerializer
  end

  def set_permissions
    # TODO: remake
    @folder.permissions.destroy_all
    params[:upload][:ids].each do |id|
      @upload.allow_access_for User.find(id)
    end
    render json: @upload
  end

  def get_permissions
    # TODO: remake
    render json: @upload.permissions.map(&:user)
  end

  def move
    # TODO: это будет работать очень медленно при большом числе файлов
    @uploads.all? { |upload| upload.move @folder }
    if @uploads.all? { |upload| upload.move @folder }
      render json: @uploads, each_serializer: UploadSerializer
    else
      render_error TextError.new('move'), 500
    end
  end

  def copy
    if @uploads.all? { |upload| upload.copy @folder }
      render json: @uploads, each_serializer: UploadSerializer
    else
      render_error TextError.new('copy'), 500
    end
  end

  private

  def upload_params
    params.require(:upload).permit(:password)
  end

end