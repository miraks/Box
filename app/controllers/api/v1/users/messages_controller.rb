class Api::V1::Users::MessagesController < Api::V1::BaseController
  find :message, only: [:destroy]
  before_filter :authenticate_user!

  def create
    recipient = User.find params[:message][:recipient_id].to_s.to_slug.normalize! # TODO: change that when users search will work
    @message = Message.new message_params.merge(user: current_user, recipient: recipient)
    @message.save
    render json: @message
  end

  def destroy
    @message.delete_by current_user
    render json: @message
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end