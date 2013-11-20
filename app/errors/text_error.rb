class TextError < BaseError
  attr_reader :message

  def initialize message
    @message = message
  end
end