class User < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  DELEGATED_MODULES = %w{friend user_message}.freeze

  before_validation :generate_name

  extend FriendlyId
  friendly_id :name

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :uploads
  has_many :folders
  has_many :purchases
  has_many :messages
  has_many :friendships
  has_many :friends, through: :friendships, source: :friend
  validates :name, presence: true

  after_create :create_default_folders

  def to_s
    name
  end

  DELEGATED_MODULES.each do |mod|
    class_eval <<-CODE, __FILE__, __LINE__ + 1
      def #{mod}
        @#{mod} ||= #{mod.classify}.new self
      end
    CODE
  end

  # Friend
  delegate :friend_of?, :considered_friend_by?, :has_friends?,
           :become_friend_with, :stop_being_friend_of,
           :friendship_with, to: :friend
  # UserMessage
  delegate :sent_messages, :received_messages, :unread_messages_count, to: :user_message

  private

  def generate_name
    self.name = email.split('@')[0]
  end

  def create_default_folders
    DefaultFoldersCreator.new(self).create!
  end

  # TODO: over thousand lines
end