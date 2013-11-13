class UploadUrlSerializer < ActiveModel::Serializer
  self.root = 'upload'

  attributes :url

  def url
    @url ||= object.generate_download_link
  end
end