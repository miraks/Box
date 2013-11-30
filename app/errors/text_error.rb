class TextError < BaseError
  attr_reader :message

  def initialize message
    @message = I18n.t "errors.messages.#{message}"
  end
end