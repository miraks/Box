class SeedHelper
  def initialize mutex, config
    @mutex = mutex
    @config = config
  end

  def synchronize &block
    @mutex.synchronize &block
  end

  def execute query
    ActiveRecord::Base.connection_pool.with_connection do |connection|
      connection.execute query
    end
  end

  def with_rescue
    begin
      yield
    rescue => e
      synchronize do
        puts e.message
        puts e.backtrace
      end
    end
  end

  def execute_with_rescue query
    with_rescue { execute query }
  end

  def insert table, attrs
    fields = attrs.keys.push(*%w(created_at updated_at)).map { |field| %Q{"#{field}"} }
    values = attrs.values.map{ |value| "'#{value}'" }.push(*%w(now() now()))
    query = %Q{INSERT INTO "#{table}" (#{fields.join(', ')}) VALUES (#{values.join(', ')}) RETURNING "id"}
    execute_with_rescue(query).getvalue(0, 0).to_i
  end

  def in_thread_pool &block
    threads = (0...@config[:users_count]).to_a.in_groups_of(group_size, false).map do |group|
      Thread.new { group.each(&block) }
    end

    threads.each &:join
  end

  def announce_creation model_name
    puts "Creating #{model_name}..."
    print "0% done"
  end

  def refresh_progress done_count
    synchronize do
      print "\r#{(done_count.to_f / @config[:users_count] * 100).round}% done"
    end
  end

  def increase_progress!
    synchronize { @progress += 1 }
    refresh_progress @progress
  end

  def reset_progress!
    synchronize { @progress = 0 }
  end

  def create model_name, &block
    inserter = -> attrs { insert model_name, attrs }

    announce_creation model_name
    reset_progress!

    in_thread_pool do |index|
      block.call inserter, index
      increase_progress!
    end

    puts
  end

  def group_size
    @group_size ||= @config[:users_count] / cpu_count
  end

  def cpu_count
    @cpu_count ||= `cat /proc/cpuinfo | grep processor | wc -l`.to_i
  end

  def words
    @words ||= File.read(Rails.root.join('db/words.txt'))
                   .split("\n")
                   .map { |word| word.to_slug.normalize.to_s }
                   .select { |word| word.length > @config[:min_word_length] }
  end

  def prepare!
    BCrypt::Engine.cost = 1
    Box::Application.eager_load!
  end
end

mutex = Mutex.new
config = {
  users_count: 5000,
  uploads_per_user: 5,
  messages_per_user: 5,
  friends_per_user: 5,
  password: '111111',
  message_words_count: 10,
  file_path: Rails.root.join("db/sample_file.txt"),
  min_word_length: 2,
  first_level_domains: %w(com net org)
}

helper = SeedHelper.new mutex, config
helper.prepare!

words = helper.words

# Users

user_ids = []
user_slugs = {}

helper.create :users do |inserter, index|
  name = words.sample + SecureRandom.hex(2)
  slug = name
  email = "#{name}@#{words.sample}.#{config[:first_level_domains].sample}"
  password = BCrypt::Password.create("#{config[:password]}#{User.pepper}").to_s

  user_id = inserter.call email: email, encrypted_password: password, name: name, slug: slug

  next if user_id.zero?

  helper.synchronize do
    user_ids << user_id
    user_slugs[user_id] = slug
  end
end

# Folders

user_folder_ids = {}

helper.create :folders do |inserter, index|
  folder_ids = []
  user_id = user_ids[index]

  root_id = inserter.call user_id: user_id, name: 'root', parent_folder_ids: '{}'
  folder_ids << root_id
  folder_ids << inserter.call(user_id: user_id, name: 'Х-Файлы', parent_folder_ids: "{#{root_id}}")
  files_id = inserter.call user_id: user_id, name: 'Файлы', parent_folder_ids: "{#{root_id}}"
  folder_ids << files_id
  ['Фото', 'Видео', 'Аудио'].each do |name|
    folder_ids << inserter.call(user_id: user_id, name: name, parent_folder_ids: "{#{[root_id, files_id].join(',')}}")
  end

  helper.synchronize do
    user_folder_ids[user_id] = folder_ids
  end
end

# Uploads

split_id = -> id { id.to_s.rjust(9, '0').insert(3, '/').insert(7, '/') }

helper.create :uploads do |inserter, index|
  user_id = user_ids[index]
  folder_ids = user_folder_ids[user_id]

  config[:uploads_per_user].times do
    original_name = words.sample + '.txt'
    name = SecureRandom.hex + '.txt'
    folder_id = folder_ids.sample

    upload_id = inserter.call user_id: user_id, original_name: original_name, file: name, folder_id: folder_id

    dir_path = Rails.root.join("public/system/upload/#{split_id[upload_id]}").to_s
    FileUtils.mkdir_p dir_path
    File.write File.join(dir_path, name), ''
  end
end

# Messages

helper.create :messages do |inserter, index|
  user_id = user_ids[index]
  user_slug = user_slugs[user_id]

  config[:messages_per_user].times do
    begin
      recipient_id = user_ids.sample
    end while user_id == recipient_id
    recipient_slug = user_slugs[recipient_id]
    conversation_id = [user_slug, recipient_slug].sort.join('_')
    body = (1..config[:message_words_count]).map{ words.sample }.join(' ')

    inserter.call user_id: user_id, recipient_id: recipient_id, body: body, conversation_id: conversation_id
  end
end

# Friendships

helper.create :friendships do |inserter, index|
  user_id = user_ids[index]
  friend_ids = []

  config[:friends_per_user].times do
    begin
      friend_id = user_ids.sample
    end while user_id == friend_id || friend_ids.include?(friend_id)
    friend_ids << friend_id

    inserter.call user_id: user_id, friend_id: friend_id
  end
end
