class Users::MessagesController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
    @message = Message.where(conversation_id: params[:id]).last
  end

end