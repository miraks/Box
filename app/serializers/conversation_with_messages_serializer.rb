class ConversationWithMessagesSerializer < ConversationSerializer
  self.root = 'conversation'

  def messages
    object.messages(current_user).with_users
  end

  has_many :messages

  has_one :user1
  has_one :user2
end
