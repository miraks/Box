class ConversationWithMessagesSerializer < ConversationSerializer
  self.root = 'conversation'

  def messages
    object.messages(current_user).with_users
  end

  has_many :messages
end
