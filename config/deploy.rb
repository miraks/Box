set :application, 'box'
set :repo_url, 'git@bitbucket.org:miraks/box.git'

set :branch, :master

set :deploy_to, '/var/www/box'
set :scm, :git

set :format, :pretty
set :log_level, :debug

set :linked_files, %w{.env}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :keep_releases, 10

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      pid_path = release_path.join 'tmp/pids/puma.box.pid'
      execute "kill -s USR2 `cat #{pid_path}`"
    end
  end

  after :finishing, 'deploy:cleanup'

end