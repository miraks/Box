class UploadSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at, :locked, :icon_url, :size, :playable

  def playable
    object.file.playable?
  end
end