class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, :friend, presence: true
  validates :friend_id, uniqueness: { scope: :user_id }
  validate  :not_same_user

  scope :with, -> user { where friend: user }

  private

  def not_same_user
    errors.add :base, 'Нельзя подружится с самим собой' if user == friend
  end
end