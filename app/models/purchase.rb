class Purchase < ActiveRecord::Base
  # TODO: only users who has purchased files can download it
  belongs_to :user
  belongs_to :upload

  before_validation :generate_link

  def download
    link = File.join File.dirname(upload.path), upload_name
    unless File.symlink? link
      File.symlink upload.path, link
    end
    link
    # TODO: delete symlink after timeout
  end

  private

  def generate_link
    self.upload_name = generate_fake_name
  end

  def generate_fake_name
    name = upload.name.to_slug.normalize! transliterations: [:russian]
    "#{name}_#{SecureRandom.hex(3)}"
  end

end