module ErrorsProcessor
  module AuthorizationErrorProcessor
    extend ActiveSupport::Concern

    included do
      rescue_from Pundit::NotAuthorizedError, with: :authorization_error_processor
    end

    protected

    def authorization_error_processor exception
      @error = AuthorizationError.new exception
      render json: @error, status: 403, serializer: BaseErrorSerializer, root: 'authorization_error'
    end
  end
end