class ExtensionIconUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::Processing::MiniMagick

  storage :file

  {normal: [50, 50], thumb: [25, 25]}.each do |name, size|
    version name do
      process :strip
      process resize_to_fill: size
      process quality: 80
      process convert: 'jpg'
    end
  end

  def store_dir
    "system/#{model.class.to_s.underscore}/#{model.extension}"
  end

  def extension_white_list
    %w(jpg jpeg gif png webp)
  end
end