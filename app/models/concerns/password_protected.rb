module PasswordProtected
  extend ActiveSupport::Concern

  include BCrypt

  included do
    role :password_manager, methods: [:know_password, :know_password?, :know_password!]

    before_save :clear_password_manager, if: :password_changed?
  end

  def password
    return @password if defined? @password
    password_hash = password_donor.try(:password_hash)
    @password = password_hash.present? ? Password.new(password_hash) : nil
  end

  def password= new_password
    self.password_hash = @password = if new_password.present?
      Password.create new_password
    else
      nil
    end
  end

  def check_password password, user
    return true if know_password? user
    return false unless self.password == password
    know_password! user
    true
  end

  def password?
    password.present?
  end

  def password_changed?
    password_hash_changed?
  end

  def password_donor
    @password_donor ||= password_hash? ? self : parents.with_password.last
  end

  def donor_password?
    password_donor.try(:password_hash).present?
  end

  protected

  def clear_password_manager
    password_manager.clear!
  end
end