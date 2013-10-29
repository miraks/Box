class User < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  # Дать пользователям вводить имя? Или генерить, а потом давать изменить ?
  before_validation :generate_name

  extend FriendlyId
  friendly_id :name

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :uploads
  has_many :folders
  has_many :purchases
  validates :name, presence: true

  after_create :create_default_folders

  private

  def generate_name
    self.name = email.split('@')[0]
  end

  def create_default_folders
    DefaultFoldersCreator.new(self).create!
  end

  # TODO: over thousand lines
end