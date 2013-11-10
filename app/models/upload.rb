class Upload < ActiveRecord::Base

  EXTENSION_REGEXP = /\.[[:alnum:]]+$/.freeze

  belongs_to :user
  belongs_to :folder
  has_many :purchases

  validates :original_name, :file, :user_id, :folder_id, presence: true

  before_destroy :copy_to_storage, if: :has_purchases?

  mount_uploader :file, FileUploader

  def name
    original_name.sub(EXTENSION_REGEXP, '')
  end

  def path
    file.path
  end

  def manipulator
    @manipulator ||= Manipulator.new self
  end
  delegate :move, :copy, to: :manipulator

  private

  def copy_to_storage
    # TODO
  end

  def has_purchases?
    purchases.exists?
  end

end