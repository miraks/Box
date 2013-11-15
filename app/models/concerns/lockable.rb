module Lockable
  extend ActiveSupport::Concern

  included do
    before_save :update_lock
  end

  def permission user
    case
    when !password? || self.user == user then :yes
    when password? then :password
    else :no
    end
  end

  private

  def update_lock
    self.locked = password? if password_changed?
    true
  end
end