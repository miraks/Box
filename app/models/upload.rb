class Upload < ActiveRecord::Base

  EXTENSION_REGEXP = /\.[[:alnum:]]+$/.freeze

  belongs_to :user
  belongs_to :folder

  validates :original_name, :file, :user_id, :folder_id, presence: true

  mount_uploader :file, FileUploader

  before_validation :set_original_name, if: :file_changed?

  def name
    original_name.sub(EXTENSION_REGEXP, '')
  end

  private

  def set_original_name
    self.original_name = file.original_name
  end

end