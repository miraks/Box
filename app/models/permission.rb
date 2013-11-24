class Permission < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  belongs_to :user
  belongs_to :upload

  validate :can_share_this, :not_with_yourself, :already_have_access

  private

  def already_have_access
    errors.add :base, 'У пользователя уже есть доступ' if user.shared.where upload: upload
  end

  def can_share_this
    errors.add :base, 'Нельзя давать доступ чужим файлам' unless owner == upload.user
  end

  def not_with_yourself
    errors.add :base, 'Нельзя дать доступ самому себе' if owner == user
  end

end