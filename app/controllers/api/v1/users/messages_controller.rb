class Api::V1::Users::MessagesController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    @messages = Message.last_in_conversations current_user
    render json: @messages
  end

  def show
    @messages = Message.where(conversation_id: params[:id]).last.conversation.messages.with_users
    @messages.each { |message| message.read current_user }
    render json: @messages
  end

  def create
    recipient = User.find params[:message][:recipient_id].to_slug.normalize! # TODO: change that when users search will work
    @message = Message.new message_params.merge(user: current_user, recipient: recipient)
    @message.save
    render json: @message
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end