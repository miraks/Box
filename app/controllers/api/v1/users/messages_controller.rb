class Api::V1::Users::MessagesController < Api::V1::BaseController
  find :user
  find :message, only: [:show]
  before_filter :authenticate_user!

  def received
    @messages = @user.received_messages.with_users
    render json: @messages
  end

  def sent
    @messages = @user.sent_messages.with_users
    render json: @messages
  end

  def show
    @message.read current_user
    render json: @message
  end

  def create
    user = User.find params[:message][:recipient_id]
    params[:message].merge! recipient_id: user.id, user_id: current_user.id
    @message = Message.new params[:message]
    @message.save
    render json: @message, meta: { success: @message.persisted? }
  end

end