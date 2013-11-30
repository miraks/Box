module ErrorsProcessor
  module InternalErrorProcessor
    extend ActiveSupport::Concern

    include do
      rescue_from StandardError, with: :internal_error_processor
    end

    protected

    def internal_error_processor exception
      @error = InternalError.new exception
      render json: @error, status: 500, serializer: BaseErrorSerializer, root: 'internal_error'
    end
  end
end