class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :recepient, class_name: 'User', foreign_key: 'recipient_id'

  validates :title, :body, presence: true
  validate  :cant_send_message_yourself

  private

  def cant_send_message_yourself
    errors.add :base, 'Нельзя отправить сообщение себе' if user == recepient
  end

end