class Upload < ActiveRecord::Base
  include Roleplayer
  include PasswordProtected

  belongs_to :user
  belongs_to :folder
  has_many :purchases

  validates :original_name, :file, :user_id, :folder_id, presence: true

  before_destroy :copy_to_storage, if: :has_purchases?

  mount_uploader :file, FileUploader

  def name
    original_name
  end

  def path
    file.path
  end

  role :secure_link_generator, methods: [:generate_download_link]
  role :manipulable, methods: [:move, :copy]

  private

  def copy_to_storage
    # TODO
  end

  def has_purchases?
    purchases.exists?
  end

end