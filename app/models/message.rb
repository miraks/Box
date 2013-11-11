class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'

  validates :title, :body, presence: true
  validate  :cant_send_message_yourself

  scope :with_users, -> { includes(:user, :recipient) }

  def read user
    return unless user == recipient
    self.read_at = Time.now
    save
  end

  private

  def cant_send_message_yourself
    errors.add :base, 'Нельзя отправить сообщение себе' if user == recipient
  end

end