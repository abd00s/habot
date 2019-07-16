# rubocop:disable all

# set path to application
app_dir = File.expand_path("../..", __FILE__)
working_directory "#{app_dir}/current"

# Set unicorn options
worker_processes 2
preload_app true
timeout 30

# Set up socket location
listen "/var/www/habot/shared/sockets/unicorn.sock", backlog: 64

# Logging
stderr_path "/var/www/habot/shared/log/unicorn.stderr.log"
stdout_path "/var/www/habot/shared/log/unicorn.stdout.log"

# Set master PID location
pid "/var/www/habot/shared/pids/unicorn.pid"

before_exec do |_server|
  ENV["BUNDLE_GEMFILE"] = "#{app_dir}/Gemfile"
end

before_fork do |server, _worker|
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

# rubocop:enable all
