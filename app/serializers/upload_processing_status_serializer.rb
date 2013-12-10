class UploadProcessingStatusSerializer < ActiveModel::Serializer
  self.root = 'upload'

  attributes :id, :file_processing
end