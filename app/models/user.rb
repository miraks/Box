class User < ActiveRecord::Base
  include Roleplayer
  include Tire::Model::Search
  include Tire::Model::Callbacks

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :uploads
  has_many :folders
  has_many :purchases
  has_many :messages
  has_many :friendships
  has_many :friends, through: :friendships, source: :friend

  validates :name, presence: true

  before_validation :generate_name
  after_create :create_default_folders

  extend FriendlyId
  friendly_id :name

  role :friend, methods: [:friend_of?, :considered_friend_by?, :has_friends?,
       :become_friend_with, :stop_being_friend_of, :friendship_with]
  role :babbler, methods: [:unread_messages_count]

  def to_s
    name
  end

  private

  def generate_name
    self.name = email.split('@')[0]
  end

  def create_default_folders
    DefaultFoldersCreator.new(self).create!
  end

  # TODO: over thousand lines
end