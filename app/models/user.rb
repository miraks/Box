class User < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :uploads
  has_many :folders

  validates :name, presence: true

  after_create :create_default_folders

  private

  def create_default_folders
    DefaultFoldersCreator.new(self).create!
  end

  # TODO: over thousand lines
end