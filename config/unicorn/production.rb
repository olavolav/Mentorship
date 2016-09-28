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
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  old_pid = File.join(app_path, 'tmp', 'pids', 'unicorn.pid.oldbin')
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts 'Someone else did the job for us.'
    end
  end

  ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)
end
