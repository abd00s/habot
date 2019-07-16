# rubocop:disable Metrics/LineLength

# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "habot"
set :repo_url, "git@github.com:abd00s/habot.git"

set :branch, ENV["BRANCH"] if ENV["BRANCH"]

set :deploy_to, "/var/www/habot"

# Default value for :pty is false
set :pty, true

append :linked_files, "config/secrets.yml", "config/database.yml"

append :linked_dirs, "bin", "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor/bundle"

set :unicorn_pid, "/var/www/habot/shared/pids/unicorn.pid"

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do
  desc "Restart application"
  task :restart do
    invoke "unicorn:legacy_restart"
  end
end

after "deploy:publishing", "deploy:restart"

namespace :sidekiq do
  task :quiet do
    on roles(:app) do
      capture("pgrep -f 'sidekiq' | xargs kill -TSTP")
    end
  end
  task :restart do
    on roles(:app) do
      execute :sudo, :systemctl, :restart, :sidekiq
    end
  end
  task :stop do
    on roles(:app) do
      execute :sudo, :systemctl, :stop, :sidekiq
    end
  end
end

after "deploy:starting", "sidekiq:quiet"
after "deploy:reverted", "sidekiq:restart"
after "deploy:published", "sidekiq:restart"

# rubocop:enable Metrics/LineLength
