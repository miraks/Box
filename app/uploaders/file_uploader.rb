class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::Processing::MiniMagick

  storage :file

  before :cache, :save_original_filename

  {normal: [50, 50], thumb: [25, 25]}.each do |name, size|
    version name, if: :image? do
      process :strip
      process resize_to_fill: size
      process quality: 80
      process convert: 'jpg'
    end
  end

  def store_dir
    "system/#{model.class.to_s.underscore}/#{split_id(model.id)}"
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def previewable?
    image? file
  end

  private

  def image? file
    (file.content_type and file.content_type.start_with? 'image') or
      file.extension.in? %w(jpg jpeg gif png webp)
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
