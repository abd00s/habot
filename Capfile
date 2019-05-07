require "capistrano/setup"

require "capistrano/deploy"

require "capistrano/rbenv"
require "capistrano/secrets_yml"
require "capistrano/scm/git"
require "capistrano/bundler"
require "capistrano/rails/migrations"
require "capistrano3/unicorn"

set :rbenv_type, :user
set :rbenv_ruby, File.read(".ruby-version").strip
set :rbenv_roles, :all

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} /usr/bin/rbenv exec"

install_plugin Capistrano::SCM::Git

set :linked_files, %w[config/secrets.yml config/database.yml]

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
