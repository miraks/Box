class UploadSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :created_at, :updated_at

  def url
    object.file.url
  end
end