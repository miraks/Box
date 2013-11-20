class AuthorizationError < BaseError
  attr_reader :exception

  def initialize exception
    @exception = exception
  end

  delegate :message, to: :exception
end