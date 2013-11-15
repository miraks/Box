class Api::V1::Users::ConversationsController < Api::V1::BaseController
  find :conversation, only: [:show]
  before_filter :authenticate_user!

  def index
    @conversations = Conversation.of current_user
    Conversation.mark_unread current_user, @conversations # Perfomance optimization
    render json: @conversations, each_serializer: ConversationWithLastMessageSerializer
  end

  def show
    @conversation.read current_user
    render json: @conversation, serializer: ConversationWithMessagesSerializer
  end
end