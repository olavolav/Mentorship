app_path = File.expand_path(File.dirname(__FILE__) + '/../..')
worker_processes 3
preload_app true
timeout 300
working_directory app_path
listen File.join(app_path, 'tmp', 'sockets', 'unicorn.sock')
stderr_path File.join(app_path, 'log', 'unicorn.log')
stdout_path File.join(app_path, 'log', 'unicorn.log')
pid File.join(app_path, 'tmp', 'pids', 'unicorn.pid')

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)
end
