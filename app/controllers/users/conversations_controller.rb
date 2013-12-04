class Users::ConversationsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
    other_user = User.find params[:id]
    @conversation = Conversation.new current_user, other_user
  end
end