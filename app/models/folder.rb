class Folder < ActiveRecord::Base

  attr_accessor :parent

  has_many :uploads
  belongs_to :user

  validates :name, presence: true

  before_save :set_parent_folders, if: :parent

  scope :root, -> { find_by "parent_folder_ids = '{}'" }

  def parents reload = false
    @parents = self.class.where(id: parent_folder_ids) if @parents.nil? || reload
    @parents
  end

  def children reload = false
    @children = self.class.where('parent_folder_ids[1] = ?', id) if @children.nil? || reload
    @children
  end

  private

  def set_parent_folders
    self.parent_folder_ids = [parent.id, *parent.parent_folder_ids]
  end

end