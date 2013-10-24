class Folder < ActiveRecord::Base

  attr_accessor :parent

  has_many :uploads
  belongs_to :user

  validates :name, presence: true

  before_save :set_parent_folders, if: :parent

  def parent_folders reload = false
    @parent_folders = self.class.where(id: parent_folder_ids).to_a if @parent_folders.nil? || reload
    @parent_folders
  end

  private

  def set_parent_folders
    self.parent_folder_ids = [parent.id, *parent.parent_folder_ids]
  end

end