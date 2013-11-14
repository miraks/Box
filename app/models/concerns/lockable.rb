module Lockable
  extend ActiveSupport::Concern

  included do
    before_save :update_lock
  end

  private

  def update_lock
    self.locked = password? if password_changed?
    true
  end
end