class UploadUrlSerializer < ActiveModel::Serializer
  self.root = 'upload'

  attributes :name, :url, :sources

  def url
    @url ||= object.generate_download_link
  end

  def sources
    object.file.sources
  end
end