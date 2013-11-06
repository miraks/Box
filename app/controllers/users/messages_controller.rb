class Users::MessagesController < ApplicationController
  before_filter :authenticate_user!
  find :user

  def index
    if params[:sent]
      @messages = @user.sent_messages
    else
      @messages = @user.received_messages
    end
    respond_to do |format|
      format.html
      format.json { render json: @messages }
    end
  end

  def show
    @message = Message.find params[:id]

    if current_user != @message.user
      @message.update_attributes read_at: Time.now
    end

    respond_to do |format|
      format.html
      format.json { render json: @message }
    end
  end

  def create
    user = User.find params[:message][:recepient_id] || :name
    if user and user != current_user
      params[:message].merge! recepient_id: user.id, user_id: current_user.id
      @message = Message.new message_params
      @message.save
    end
    redirect_to :back
  end

  private

  def message_params
    params.require(:message).permit(:recepient_id, :title, :body, :user_id)
  end

end