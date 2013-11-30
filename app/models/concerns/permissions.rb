 module Permissions

  def allow_access_for user
    self.user.permissions.create user: user, item: self
  end

  def allow_access_for_group klass
    self.user.permissions.create item: self, type: klass
  end

  def permission_required?
    self.permissions.exists?
  end

end