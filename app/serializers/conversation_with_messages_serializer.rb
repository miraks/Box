class ConversationWithMessagesSerializer < ConversationSerializer
  self.root = 'conversation'

  def messages
    object.messages.with_users
  end

  has_many :messages
end
