class Upload < ActiveRecord::Base
  include Roleplayer
  include PasswordProtected
  include Lockable

  belongs_to :user
  belongs_to :folder
  has_many :purchases

  validates :original_name, :file, :user_id, :folder_id, presence: true

  before_save :update_lock
  before_destroy :copy_to_storage, if: :has_purchases?

  mount_uploader :file, FileUploader

  role :secure_link_generator, methods: [:generate_download_link]
  role :manipulable, methods: [:move, :copy]

  def access_for user
    self.user.permissions.create user: user, upload: self
  end

  def access_for_group group
    self.user.permissions.create upload: self, permission_type: group
  end

  def name
    original_name
  end

  def path
    file.path
  end

  def parents
    folder.parents
  end

  private

  def upload_lock

  end

  def copy_to_storage
    # TODO
  end

  def has_purchases?
    purchases.exists?
  end

end