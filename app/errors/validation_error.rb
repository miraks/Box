class ValidationError < BaseError
  def initialize errors_or_record
    errors_or_record = errors_or_record.errors if errors_or_record.kind_of? ActiveRecord::Base
    @errors = errors_or_record
  end

  def message
    @errors.full_messages.join("\n")
  end
end