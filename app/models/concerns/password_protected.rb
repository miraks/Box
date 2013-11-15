module PasswordProtected
  extend ActiveSupport::Concern

  include BCrypt

  def password
    return @password if defined? @password
    password_hash = self.password_hash || parents.with_password.last.try(:password_hash)
    @password = password_hash.present? ? Password.new(password_hash) : nil
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