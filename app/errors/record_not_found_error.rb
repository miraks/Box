class RecordNotFoundError < BaseError
  def initialize error
    @error = error
  end

  def message
    I18n.t "errors.messages.not_found", name: record_class_name
  end

  private

  def record_class_name
    match = @error.message.match(/find (\w+) with/)
    return '' unless match.present?
    record_class = match[1]
    I18n.t "activerecord.models.#{record_class.underscore}"
  end
end