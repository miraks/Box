class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'

  validates :body, :user_id, :recipient_id, presence: true
  validate  :cant_send_message_yourself

  before_create :set_conversation_id

  scope :with_users, -> { includes(:user, :recipient) }
  scope :to, -> user { where recipient: user }
  scope :of, -> user { where 'user_id = :user OR recipient_id = :user', user: user }
  scope :unread, -> { where read_at: nil }
  scope :unread_by, -> user { to(user).unread }
  scope :not_deleted_by, -> user do
    where '(user_id = :user AND deleted_by_user = false)
           OR (recipient_id = :user AND deleted_by_recipient = false)',
          user: user
  end
  scope :last_in_conversations, -> user do
    ids = of(user).group(:conversation_id).select('max(messages.id)')
    where id: ids
  end

  def conversation
    return unless user && recipient
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

  def delete_by user
    public_send "deleted_by_#{role user}=", true
    save
  end

  private

  def role user
    user == recipient ? :recipient : :user
  end

  def cant_send_message_yourself
    errors.add :base, :not_to_self if user == recipient
  end

  def set_conversation_id
    self.conversation_id ||= conversation.id
  end
end