class Api::V1::FoldersController < Api::V1::BaseController
  before_filter :find_folder
  before_filter :has_access

  def show
    render json: @folder
  end

  private

  def find_folder
    @folder = Folder.find params[:folder_id] || params[:id]
  end

  def has_access
    # TODO
  end

end