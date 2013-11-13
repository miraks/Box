class Api::V1::UploadsController < Api::V1::BaseController
  find :folder, only: [:create]
  find :upload, only: [:download]
  find :folder, in: :upload, only: [:move, :copy]
  find :uploads, in: :upload, only: [:move, :copy]

  def create
    @upload = Upload.new user: current_user, file: params[:file], folder: @folder
    success = @upload.save
    render json: @upload, meta: { success: success }
  end

  def download
    authorize @upload, args: params[:password]
    render json: @upload, serializer: UploadUrlSerializer
  end

  def move
    # TODO: обрабатывать ошибки
    # TODO: это будет работать очень медленно при большом числе файлов
    @uploads.each { |upload| upload.move @folder }
    render json: @uploads, each_serializer: UploadSerializer
  end

  def copy
    @uploads.each { |upload| upload.copy @folder }
    render json: @uploads, each_serializer: UploadSerializer
  end

end