class Api::V1::Users::ConversationsController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    @conversations = Conversation.of current_user
    Conversation.mark_unread current_user, @conversations # Perfomance optimization
    render json: @conversations, each_serializer: ConversationWithLastMessageSerializer
  end

  def show
    other_user = User.find params[:id]
    @conversation = Conversation.new current_user, other_user
    @conversation.read current_user
    render json: @conversation, serializer: ConversationWithMessagesSerializer
  end
end