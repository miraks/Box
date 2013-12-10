class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::Backgrounder::Delay
  include CarrierWave::Processing::MiniMagick
  include CarrierWave::Processors::Audio

  IMAGE_FORMATS = { normal: [50, 50], thumb: [25, 25] }.freeze
  AUDIO_FORMATS = { ogg: 'libvorbis' }.freeze

  IMAGE_EXTENSIONS = %w(jpg jpeg gif png webp).freeze
  AUDIO_EXTENSIONS = %w(mp3 ogg aac flac wav m4a m4b).freeze
  VIDEO_EXTENSIONS = %w().freeze
  MEDIA_EXTENSIONS = (AUDIO_EXTENSIONS + VIDEO_EXTENSIONS).freeze

  storage :file

  before :cache, :save_original_filename

  IMAGE_FORMATS.each do |name, size|
    version name, if: :image? do
      process :strip
      process resize_to_fill: size
      process quality: 80
    end
  end

  AUDIO_FORMATS.each do |format, codec|
    version format, if: :audio? do
      def full_filename filename
        super.split('.').tap(&:pop).push(version_name).join('.')
      end

      process encode_audio: [format, codec]
    end
  end

  def store_dir
    "system/#{model.class.to_s.underscore}/#{split_id(model.id)}"
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def sources
    return [] unless playable?
    type = [:audio].find { |type| send "#{type}?", file }
    formats = self.class.const_get("#{type.upcase}_FORMATS").keys
    formats.map { |format| url format }
  end

  # TODO: cache file type in database on creation
  def previewable?
    image? file
  end

  def playable?
    audio? file
  end

  private

  def image? file
    (file.content_type and file.content_type.start_with? 'image') or
      file.extension.in? IMAGE_EXTENSIONS
  end

  def audio? file
    (file.content_type and file.content_type.start_with? 'audio') or
      file.extension.in? AUDIO_EXTENSIONS
  end

  def save_original_filename file
    model.original_name ||= file.original_filename
  end

  def secure_token
    var = :@file_secure_token
    model.instance_variable_get var or model.instance_variable_set var, SecureRandom.hex
  end

  def split_id id
    id.to_s.rjust(9, '0').insert(3, '/').insert(7, '/')
  end

end
