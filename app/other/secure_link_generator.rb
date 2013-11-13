# TODO: удалять временные линки

SecureLinkGenerator = Struct.new(:upload) do
  LINKS_FOLDER_PATH = 'public/system/download'.freeze

  def generate_download_link
    FileUtils.mkdir_p dir_path
    FileUtils.symlink upload.path, path
    url
  end

  def url
    @url ||= File.join LINKS_FOLDER_PATH.sub('public', ''), upload.id.to_s, random_part, upload.name
  end

  def path
    @path ||= Rails.root.join(dir_path, upload.name).to_s
  end

  def dir_path
    @dir_path ||= Rails.root.join(LINKS_FOLDER_PATH, upload.id.to_s, random_part).to_s
  end

  private

  def random_part
    @random_part ||= SecureRandom.hex
  end
end