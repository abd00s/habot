# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"
require "capistrano/rbenv"
require "capistrano/secrets_yml"

# set :default_env, {
#   path: '/usr/local/rbenv/plugins/ruby-build/bin:/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH',
#   rbenv_root: '/usr/local/rbenv'
# }
# set :default_env, {
#   'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
# }
# set :default_environment, {
#   'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
# }
set :rbenv_type, :user
set :rbenv_ruby, "2.5.1"
set :rbenv_roles, :all

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} /usr/bin/rbenv exec"
# set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# set :rbenv_custom_path, '/usr/bin/rbenv'

# Load the SCM plugin appropriate to your project:
#
# require "capistrano/scm/hg"
# install_plugin Capistrano::SCM::Hg
# or
# require "capistrano/scm/svn"
# install_plugin Capistrano::SCM::Svn
# or
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Include tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#   https://github.com/capistrano/passenger
#
# require "capistrano/rvm"

# require "capistrano/chruby"
require "capistrano/bundler"
# require "capistrano/rails/assets"
require "capistrano/rails/migrations"
require "capistrano3/unicorn"
# require "capistrano/passenger"

set :linked_files, %w{config/secrets.yml config/database.yml}

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
