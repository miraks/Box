module PasswordProtected
  extend ActiveSupport::Concern

  include BCrypt

  def password
    return nil unless password_hash?
    @password ||= Password.new password_hash
  end

  def password= new_password
    self.password_hash = @password = if new_password.present?
      Password.create new_password
    else
      nil
    end
  end

  def password?
    password.present?
  end

  def password_changed?
    password_hash_changed?
  end

end