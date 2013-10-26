class Api::BaseController < ActionController::Metal
  # Список всех доступных модулей можно посмотреть
  # с помощью ActionController::Base.without_modules
  include ActionController::Rendering
  include ActionController::Renderers::All
  include AbstractController::Callbacks
  include ActionController::Helpers
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection
  include ActionController::Serialization
  include Rails.application.routes.url_helpers

  protect_from_forgery with: :null_session
end