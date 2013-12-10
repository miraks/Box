class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :created_at, :online?, :used_space, :space_limit, :company_data, :profile, :is_company

  has_one :avatar
end
