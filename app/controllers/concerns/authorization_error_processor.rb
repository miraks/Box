module AuthorizationErrorProcessor
  extend ActiveSupport::Concern

  included do
    rescue_from Pundit::NotAuthorizedError, with: :authorization_error_processor
  end

  protected

  # Fill free to redefine that
  def authorization_error_processor exception
    @error = AuthorizationError.new exception
    render json: @error, status: 403
  end
end