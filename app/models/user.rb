class User < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  # TODO: over thousand lines
end
