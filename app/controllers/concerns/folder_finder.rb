module FolderFinder
  extend ActiveSupport::Concern

  def find_folder
    @folder = Folder.find(params[:folder_id] || params[:id])
  end
end