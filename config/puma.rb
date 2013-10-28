require 'dotenv'
Dotenv.load

app_root = ENV['BOX_PATH']

config = {
  min_threads_count: ENV['BOX_MIN_THREADS_COUNT'],
  max_threads_count: ENV['BOX_MAX_THREADS_COUNT'],
  workers_count: ENV['BOX_WORKERS_COUNT'],
  env: ENV['BOX_ENV']
}

threads config.fetch(:min_threads_count, 4).to_i, config.fetch(:max_threads_count, 8).to_i
workers config.fetch(:workers_count, 4).to_i
bind 'unix://tmp/sockets/puma.box.sock'
pidfile File.join(app_root, 'tmp/pids/puma.box.pid')
state_path File.join(app_root, 'tmp/pids/puma.box.state')
activate_control_app 'unix://tmp/sockets/pumactl.box.sock'
environment config.fetch(:env, 'production')

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

preload_app!