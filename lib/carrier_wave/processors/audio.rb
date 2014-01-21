module CarrierWave
  module Processors
    module Audio
      def encode_audio format, codec
        dir = File.dirname current_path
        tmpfile = File.join dir, "#{SecureRandom.hex}.#{format}"

        file = FFMPEG::Movie.new current_path
        file.transcode tmpfile, audio_codec: codec

        FileUtils.move tmpfile, current_path
      end
    end
  end
end