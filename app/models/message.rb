class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'

  validates :body, :user_id, :recipient_id, presence: true
  validate  :cant_send_message_yourself

  before_create :set_conversation_id

  scope :with_users, -> { includes(:user, :recipient) }
  scope :of, -> user { where 'user_id = :user OR recipient_id = :user', user: user }
  scope :last_in_conversations, -> user do
    ids = of(user).group(:conversation_id).select('max(id)')
    where "id in (#{ids.to_sql})"
  end

  def conversation
    return nil unless user && recipient
    @conversation ||= Conversation.new user, recipient
  end

  def other user
    recipient == user ? self.user : recipient
  end

  def read user
    return unless user == recipient
    self.read_at = Time.now
    save
  end

  private

  def cant_send_message_yourself
    errors.add :base, 'Нельзя отправить сообщение себе' if user == recipient
  end

  private

  def set_conversation_id
    self.conversation_id ||= conversation.id
  end
end