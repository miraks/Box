class Api::V1::Users::MessagesController < Api::V1::BaseController
  find :message, only: [:destroy]
  before_filter :authenticate_user!

  def create
    recipient = User.find_by slug: params[:message][:recipient_id]
    return render_error TextError.new('recipient_not_found'), 500
    @message = Message.new message_params.merge(user: current_user, recipient: recipient)
    if @message.save
      render json: @message
    else
      render_error @message, 403
    end
  end

  def destroy
    if @message.delete_by current_user
      render json: @message
    else
      render_error @message, 403
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end