# IMPORTANT NOTE! Run without bullet

cpu_count = `cat /proc/cpuinfo | grep processor | wc -l`.to_i

# We will need bigger pool
Rails.application.config.after_initialize do
  ActiveRecord::Base.connection_pool.disconnect!
  ActiveSupport.on_load(:active_record) do
    config = Rails.application.config.database_configuration[Rails.env]
    config['pool'] = cpu_count * 4
    ActiveRecord::Base.establish_connection(config)
  end
end

Box::Application.eager_load!

config = {
  users_count: 1000,
  uploads_per_user: 20,
  messages_per_user: 20,
  friends_per_user: 20,
  password: '111111',
  message_words_count: 10,
  file_path: Rails.root.join("db/sample_file.txt"),
  min_word_length: 2,
  first_level_domains: %w(com net org)
}

mutex = Mutex.new
threads = []
group_size = config[:users_count] / cpu_count

words = File.read(Rails.root.join('db/words.txt')).split("\n").select { |word| word.length > config[:min_word_length] }

puts 'Creating users...'
print '0% done'

users = []

threads = (0...config[:users_count]).to_a.in_groups_of(group_size, false).map do |group|
  Thread.new do
    group.each do
      begin
        user = User.create email: "#{words.sample}@#{words.sample}.#{config[:first_level_domains].sample}",
                    password: config[:password],
                    password_confirmation: config[:password]
      rescue => e
        mutex.synchronize do
          puts e.message
          puts e.backtrace
          puts 'User creation failed'
        end
      end

      mutex.synchronize do
        users.push user

        print "\r#{(users.length.to_f / config[:users_count] * 100).round}% done"
      end
    end
  end
end

threads.each &:join

puts
puts 'Creating other things...'
print '0% done'

processed_count = 0

threads = (0...config[:users_count]).to_a.in_groups_of(group_size, false).map do |group|
  Thread.new do
    group.each do |index|
      user = users[index]

      folders = user.folders.to_a
      config[:uploads_per_user].times do
        begin
          user.uploads.create folder: folders.sample, file: File.new(config[:file_path])
        rescue => e
          mutex.synchronize do
            puts e.message
            puts e.backtrace
            puts 'Upload creation failed'
          end
        end
      end

      config[:messages_per_user].times do
        begin
          recipient = users.sample
        end while !recipient || recipient == user
        begin
          user.messages.create recipient: recipient,
                               body: (1..config[:message_words_count]).map{ words.sample }.join(' ')
        rescue => e
          mutex.synchronize do
            puts e.message
            puts e.backtrace
            puts 'Message creation failed'
          end
        end
      end

      config[:friends_per_user].times do
        begin
          friend = users.sample
        end while !friend || friend == user || user.friends.include?(friend)
        begin
          user.friendships.create friend: friend
        rescue => e
          mutex.synchronize do
            puts e.message
            puts e.backtrace
            puts 'Friendship creation failed'
          end
        end
      end

      mutex.synchronize do
        processed_count += 1
        print "\r#{(processed_count.to_f / config[:users_count] * 100).round}% done"
      end
    end
  end
end

threads.each &:join

puts