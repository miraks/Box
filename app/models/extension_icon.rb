class ExtensionIcon
  include ActiveModel::SerializerSupport

  attr_reader :extension
  attr_accessor :icon

  def initialize extension
    @extension = normalize extension
  end

  def save
    uploader.store! icon
    storage[extension] = uploader.filename
    drop_cache!
    true
  end

  def destroy
    storage.delete extension
    drop_cache!
    true
  end

  def persisted?
    storage.has_key? extension
  end

  def self.for extension
    icons_cache[normalize(extension)]
  end

  def self.all
    icons_cache.values
  end

  private

  def uploader
    return @uploader if @uploader
    @uploader = ExtensionIconUploader.new self
    @uploader.retrieve_from_store! storage[extension] if persisted?
    @uploader
  end
  delegate :url, :path, to: :uploader

  def self.icons_cache
    @icons_cache ||= storage.keys.each_with_object({}) { |extension, res| res[extension] = new extension }
  end

  # TODO: drop cache across different processes
  def self.drop_cache!
    @icons_cache = nil
  end

  def self.storage
    @storage ||= RedisConnection::Hash.new 'ext_icons'
  end

  def self.normalize extension
    extension = extension.to_s
    extension = extension[1..-1] if extension.start_with? '.'
    extension
  end

  delegate :drop_cache!, :storage, :normalize, to: :class
end