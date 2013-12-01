module PermissionCheck
  extend ActiveSupport::Concern

  included do
    class_attribute :item, instance_accessor: false, instance_writer: false
  end

  def item
    public_send self.class.item
  end

  protected

  def has_permission? password
    permission = item.permission user
    permission == :yes or (permission == :password and item.check_password password, user)
  end
end