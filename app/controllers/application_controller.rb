class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  alias :logged_in? :user_signed_in?
  helper_method :logged_in?
end
