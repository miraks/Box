class Api::V1::Users::MessagesController < Api::V1::BaseController
  find :user
  before_filter :authenticate_user!

  def received
    @messages = @user.received_messages
    render json: @messages
  end

  def sent
    @messages = @user.sent_messages
    render json: @messages
  end

  def show
    @message = Message.find params[:id]
    if current_user != @message.user
      @message.update_attributes read_at: Time.now
    end
    render json: @message
  end

  def create
    user = User.find params[:message][:recepient_id]
    if user
      params[:message].merge! recepient_id: user.id, user_id: current_user.id
      @message = Message.new params[:message]
      @message.save
    end
    render json: @message, meta: { success: @message.persisted? }
  end

end