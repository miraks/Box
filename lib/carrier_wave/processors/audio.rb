module CarrierWave
  module Processors
    module Audio
      def encode_audio format, codec
        dir = File.dirname current_path
        tmpfile = File.join dir, 'tmpfile'
        new_path = current_path.split('.').tap(&:pop).push(format).join('.')

        FileUtils.move current_path, tmpfile

        file = FFMPEG::Movie.new tmpfile
        file.transcode new_path, audio_codec: codec

        FileUtils.move new_path, current_path
        File.delete tmpfile
      end
    end
  end
end