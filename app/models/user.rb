class User < ActiveRecord::Base
  include Roleplayer
  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :name, type: 'string', boost: 10, analyzer: 'snowball'
    indexes :slug, type: 'string', analyzer: 'snowball'
    indexes :created_at, type: 'date'
  end

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

  def self.search params
    tire.search(load: true) do
      query { string "name: #{params[:query]}*" } if params[:query].present?
    end
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