class UploadSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at, :locked

  has_one :user # TODO: remove later
end