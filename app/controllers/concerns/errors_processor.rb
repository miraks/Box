module ErrorsProcessor
  extend ActiveSupport::Concern

  include AuthorizationErrorProcessor
  include RecordNotFoundErrorProcessor
  include InternalErrorProcessor

  def render_error error, status
    render json: error, status: status, serializer: BaseErrorSerializer, root: error.class.to_s.underscore
  end
end