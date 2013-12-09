class Upload < ActiveRecord::Base
  include Roleplayer
  include PasswordProtected
  include Lockable
  include Permissions

  belongs_to :user
  belongs_to :folder
  has_many :purchases
  has_many :permissions, as: :item

  validates :original_name, :file, :size, :user_id, :folder_id, presence: true
  validate :check_limit

  before_validation :set_size, on: :create
  after_create :notify_user
  before_destroy :copy_to_storage, if: :has_purchases?

  mount_uploader :file, FileUploader
  process_in_background :file

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

  def extension
    file.file.extension
  end

  def icon_url type = nil
    (file.previewable? and file.url(type)) or ExtensionIcon.for(extension).try(:url, type)
  end

  private

  def check_limit
    errors.add :base, :not_enough_space unless user.has_space_for? self
  end

  def set_size
    self.size ||= file.size
  end

  def notify_user
    user.uploaded! self
  end

  def copy_to_storage
    # TODO
  end

  def has_purchases?
    purchases.exists?
  end

end