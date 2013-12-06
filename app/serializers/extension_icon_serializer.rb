class ExtensionIconSerializer < ActiveModel::Serializer
  attributes :extension, :url

  def url
    object.url :normal
  end
end