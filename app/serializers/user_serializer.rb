class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :created_at, :online?, :used_space, :space_limit, :company_info, :profile_info, :last_online_time, :is_company

  has_one :avatar
end
