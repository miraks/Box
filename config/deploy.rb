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

set :bundle_flags, ''
set :bundle_binstubs, false
set :bundle_dir, nil
set :bundle_roles, :app

fetch(:default_env).merge! rvm_path: "/home/box/.rvm"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      pid_path = release_path.join 'tmp/pids/puma.box.pid'
      if test "[ -f #{pid_path} ]"
        info 'Restart puma'
        pid = capture "cat #{pid_path}"
        execute "kill -s USR2 #{pid}"
      else
        info 'Start puma'
        puma_bin_path = release_path.join 'bin/puma'
        puma_config_path = release_path.join 'config/puma.rb'
        execute "#{puma_bin_path} -d -C #{puma_config_path}"
      end
    end
  end

  after :finishing, 'deploy:cleanup'

end