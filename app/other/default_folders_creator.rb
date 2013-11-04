DefaultFoldersCreator = Struct.new(:user) do
  DEFAULT_FOLDERS = ['Х-Файлы', 'Файлы' => ['Фото', 'Видео', 'Аудио']].freeze
  ROOT_NAME = 'root'.freeze

  def create!
    folders = DEFAULT_FOLDERS.dup
    folders_with_children = folders.extract_options!
    @root = create_folder ROOT_NAME, nil
    create_folders folders
    folders_with_children.each { |parent, children| create_folders children, parent }
  end

  private

  def create_folders folders, parent = @root
    folders = Array.wrap folders
    parent = create_folder parent if parent.kind_of? String
    folders.each { |folder| create_folder folder, parent }
  end

  def create_folder name, parent = @root
    parent = create_folder parent if parent.kind_of? String
    Folder.create name: name, user: user, parent: parent
  end

end