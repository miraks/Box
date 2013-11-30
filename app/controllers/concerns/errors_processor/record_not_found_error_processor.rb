module ErrorsProcessor
  module RecordNotFoundErrorProcessor
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_error_processor
    end

    protected

    def record_not_found_error_processor exception
      @error = RecordNotFoundError.new exception
      render json: @error, status: 404, serializer: BaseErrorSerializer, root: 'record_not_found_error'
    end
  end
end