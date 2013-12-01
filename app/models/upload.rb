class Upload < ActiveRecord::Base
  include Roleplayer
  include PasswordProtected
  include Lockable
  include Permissions

  belongs_to :user
  belongs_to :folder
  has_many :purchases
  has_many :permissions, as: :item

  validates :original_name, :file, :user_id, :folder_id, presence: true

  before_save :update_lock
  before_destroy :copy_to_storage, if: :has_purchases?

  mount_uploader :file, FileUploader

  role :secure_link_generator, methods: [:generate_download_link]
  role :manipulable, methods: [:move, :copy]

  def name
    original_name
  end

  def path
    file.path
  end

  def parents
    ids = folder.parent_folder_ids.unshift folder.id
    Folder.where id: ids
  end

  private

  def copy_to_storage
    # TODO
  end

  def has_purchases?
    purchases.exists?
  end

end