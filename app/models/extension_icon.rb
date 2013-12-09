class ExtensionIcon
  include ActiveModel::SerializerSupport
  extend ActiveModel::Callbacks

  attr_reader :extension
  attr_accessor :icon

  define_model_callbacks :save, :destroy

  after_save  :notify_about_update
  after_destroy :notify_about_update

  def initialize extension
    @extension = normalize extension
  end

  def save
    run_callbacks :save do
      uploader.store! icon
      storage[extension] = uploader.filename
      true
    end
  end

  def destroy
    run_callbacks :destroy do
      storage.delete extension
      true
    end
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

  def notify_about_update
    channel.publish extension
  end

  def self.storage
    @storage ||= RedisConnection::Hash.new 'ext_icons'
  end

  def self.channel
    @channel ||= RedisConnection::Channel.new 'ext_icons'
  end

  def self.icons_cache
    return @icons_cache if @icons_cache
    subscribe_on_icon_changes!
    @icons_cache = storage.keys.each_with_object({}) { |extension, res| res[extension] = new extension }
  end

  def self.normalize extension
    extension = extension.to_s
    extension = extension[1..-1] if extension.start_with? '.'
    extension
  end
  delegate :storage, :channel, :icons_cache, :normalize, to: :class

  def self.subscribe_on_icon_changes!
    return if @subscribed_on_icon_changes
    channel.subscribe do |message|
      drop_cache!
    end
    @subscribed_on_icon_changes = true
  end

  def self.drop_cache!
    @icons_cache = nil
  end
end