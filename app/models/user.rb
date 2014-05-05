class User < ActiveRecord::Base
  include Roleplayer

  PROFILE_FIELDS = [:birthday, :city].freeze
  COMPANY_DATA_FIELDS = [:name, :activities, :site_link, :address, :phone_number].freeze
  DEFAULT_SPACE_LIMIT = 2.gigabytes

  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :uploads
  has_many :folders
  has_many :purchases
  has_many :messages
  has_many :friendships
  has_many :friends, through: :friendships, source: :friend
  has_many :permissions, foreign_key: 'owner_id'
  has_many :shared, class_name: 'Permission'

  validates :name, :email, :space_limit, :used_space, presence: true

  before_validation :generate_name, on: :create
  before_validation :set_space_limit, on: :create
  after_create :create_default_folders

  extend FriendlyId
  friendly_id :name

  scope :companies, -> { where is_company: true }
  scope :not_companies, -> { where is_company: false }

  role :friend, methods: [:friend_of?, :considered_friend_by?, :has_friends?,
       :become_friend_with, :stop_being_friend_of, :friendship_with, :online_friends]
  role :babbler, methods: [:unread_messages_count]
  role :onliner, methods: [:online!, :online?, :last_online_time]
  role :uploader, methods: [:uploaded!, :update_used_space!, :calculate_used_space,
       :has_space_for?]
  role :company, methods: []

  def shared
    Permission.where(user_id: self.id)
  end

  def has_access? item
    # TODO: решить доступ к чужим папкам/файлам по умолчанию закрыт или открыт?
    !item.permission_required? || shared.where(item: item).exists?
  end

  def to_s
    name
  end

  private

  def generate_name
    self.name ||= email.split('@')[0]
  end

  def set_space_limit
    self.space_limit ||= is_company? ? Company::DEFAULT_SPACE_LIMIT : DEFAULT_SPACE_LIMIT
  end

  def create_default_folders
    DefaultFoldersCreator.new(self).create!
  end

  # TODO: over thousand lines
end
