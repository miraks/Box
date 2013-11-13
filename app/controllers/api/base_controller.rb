class Api::BaseController < ActionController::Metal
  # Список всех доступных модулей можно посмотреть
  # с помощью ActionController::Base.without_modules

  # Rails modules
  include ActionController::Rendering
  include ActionController::Renderers::All
  include AbstractController::Callbacks
  include ActionController::Helpers
  include ActionController::Cookies
  include ActionController::Serialization
  include ActionController::DataStreaming
  include ActionController::Rescue
  include Rails.application.routes.url_helpers

  # Gems modules
  include Devise::Controllers::Helpers
  # Разкомментить если будет нужно
  # include Devise::Controllers::UrlHelpers
  include Pundit

  # Our modules
  include CustomFinder
  include AuthorizationErrorProcessor

end