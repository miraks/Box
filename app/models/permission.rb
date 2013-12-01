class Permission < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  belongs_to :user
  belongs_to :item, polymorphic: true

  validate :can_share_this, :not_with_yourself, :already_have_access

  private

  #TODO: засунуть переводы в yml
  def already_have_access
    errors.add :base, 'У пользователя уже есть доступ' if user.shared.where(item: item).exists?
  end

  def can_share_this
    errors.add :base, 'Нельзя давать доступ чужим файлам/папкам' unless owner == item.user
  end

  def not_with_yourself
    errors.add :base, 'Нельзя дать доступ самому себе' if owner == user
  end

end