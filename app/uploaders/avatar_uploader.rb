class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::Processing::MiniMagick

  storage :file

  {normal: [150, 150], small: [30, 30]}.each do |name, size|
    version name do
      process :strip
      process resize_to_fill: size
      process quality: 80
      process convert: 'jpg'
    end
  end

  def store_dir
    "system/#{model.class.to_s.underscore}/#{split_id(model.id)}"
  end

  private

  def split_id id
    id.to_s.rjust(9, '0').insert(3, '/').insert(7, '/')
  end

end
