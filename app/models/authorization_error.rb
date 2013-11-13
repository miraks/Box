AuthorizationError = Struct.new(:exception) do
  include ActiveModel::SerializerSupport

  delegate :message, to: :exception
end