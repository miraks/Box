class Users::ConversationsController < ApplicationController
  find :conversation, only: [:show]
  before_filter :authenticate_user!

  def index
  end

  def show
  end
end