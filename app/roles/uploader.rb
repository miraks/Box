Uploader = Struct.new(:user) do
  def uploaded! upload
    user.used_space += upload.size
    user.save
  end

  def update_used_space!
    user.used_space = calculate_used_space
    user.save
  end

  def calculate_used_space
    user.uploads.sum('uploads.size')
  end

  def has_space_for? upload
    user.used_space + upload.size <= user.space_limit
  end
end