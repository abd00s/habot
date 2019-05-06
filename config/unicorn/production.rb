# set path to application
app_dir = File.expand_path("../../..", __FILE__)
shared_dir = "#{app_dir}/shared"
working_directory app_dir

# Set unicorn options
worker_processes 2
preload_app true
timeout 30

# Set up socket location
# listen "#{shared_dir}/sockets/unicorn.sock", :backlog => 64
listen "/var/www/habot/shared/sockets/unicorn.sock", backlog: 64

# Logging
# stderr_path "#{shared_dir}/log/unicorn.stderr.log"
# stdout_path "#{shared_dir}/log/unicorn.stdout.log"
stderr_path "/var/www/habot/shared/log/unicorn.stderr.log"
stdout_path "/var/www/habot/shared/log/unicorn.stdout.log"

# Set master PID location
pid "/var/www/habot/shared/pids/unicorn.pid"

before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "#{app_dir}/current/Gemfile"
end

before_fork do |server, _worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  # if defined?(ActiveRecord::Base)
  #   ActiveRecord::Base.connection.disconnect!
  # end

  # Before forking, kill the master process that belongs to the .oldbin PID.
  # This enables 0 downtime deploys.
  old_pid = "#{server.config[:pid]}.oldbin"

  if File.exist?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end
