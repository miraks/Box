class ApplicationController < ActionController::Base
  include Pundit
  include CustomFinder
  include OnlineMarker
  include ErrorsProcessor

  protect_from_forgery with: :exception

  alias :logged_in? :user_signed_in?
  helper_method :logged_in?

  before_filter :configure_permitted_parameters, if: :devise_controller?

  # Hack until fix of
  # https://github.com/rubysl/rubysl-date/issues/3
  def current_user
    retried = false
    begin
      super
    rescue => e
      return raise if retried
      retried = true
      retry
    end
  end

  def after_sign_in_path_for resource
    user_path resource
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :is_company <<
      { company_data: [:name, :activities, :site_link, :address, :phone_number] }
  end
end
