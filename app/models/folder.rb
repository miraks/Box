class Folder < ActiveRecord::Base
  include Roleplayer
  include PasswordProtected
  include Lockable
  include Permissions

  attr_accessor :parent

  has_many :uploads
  has_many :permissions, as: :item
  belongs_to :user

  validates :user, :name, presence: true
  validate :not_set_password_on_root

  before_save :set_parent_folders, if: :parent

  scope :root, -> { find_by "parent_folder_ids = '{}'" }
  scope :with_password, -> { where.not password_hash: nil }

  def root?
    parent_folder_ids.empty?
  end

  def parents reload = false
    @parents = self.class.where(id: parent_folder_ids) if @parents.nil? || reload
    @parents
  end

  def children reload = false
    @children = self.class.where('parent_folder_ids[1] = ?', id) if @children.nil? || reload
    @children
  end

  private

  def not_set_password_on_root
    errors.add :password, :not_on_root if root? && password?
  end

  def set_parent_folders
    self.parent_folder_ids = [parent.id, *parent.parent_folder_ids]
  end

end