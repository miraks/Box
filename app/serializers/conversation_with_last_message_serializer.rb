class ConversationWithLastMessageSerializer < ConversationSerializer
  self.root = 'conversation'

  has_one :last_message
end
