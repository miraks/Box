class InternalError < BaseError
  attr_reader :exception

  def initialize exception
    @exception = exception
  end

  def message
    I18t.t 'errors.messages.internal'
  end
end