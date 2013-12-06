ExtensionIconPolicy = Struct.new(:user, :extension_icon) do
  def admin?
    user.try :is_admin?
  end

  alias :index?   :admin?
  alias :create?  :admin?
  alias :destroy? :admin?
end