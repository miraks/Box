module PasswordProtected
  extend ActiveSupport::Concern

  include BCrypt

  def password
    return nil unless password_hash?
    @password ||= Password.new password_hash
  end

  def password= new_password
    self.password_hash = @password = Password.create new_password
  end

  def password?
    password.present?
  end
end