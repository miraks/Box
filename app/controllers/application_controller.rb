class ApplicationController < ActionController::Base
  include Pundit
  include CustomFinder
  include OnlineMarker
  include ErrorsProcessor

  protect_from_forgery with: :exception

  alias :logged_in? :user_signed_in?
  helper_method :logged_in?

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :is_company <<
      { company_data: [:name, :activities, :site_link, :address, :phone_number] }
  end
end
