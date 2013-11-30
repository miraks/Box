module Lockable
  extend ActiveSupport::Concern

  included do
    before_save :update_lock
  end

  def permission user
    case
    when self.user == user || !password? && user.has_access?(self) then :yes
    when password? then :password
    else :no
    end
  end

  private

  def update_lock
    self.locked = password? || permission_required?
    true
  end
end