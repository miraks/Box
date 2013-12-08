class Company
  DEFAULT_SPACE_LIMIT = 5.gigabytes

  attr_reader :user

  def initialize user
    raise ArgumentError.new('User should be a company') unless user.is_company?
    @user = user
  end

end