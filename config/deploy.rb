set :stages, %w(production demo)
set :default_stage, "production"

require "bundler/capistrano"
require 'capistrano/ext/multistage'

set :user, "tommyblue"
set :use_sudo, false

set :scm, :git
set :application, "rubyfatt"
set :repository,  "git-tommyblue@git.kreations.it:rails/rubyfatt.git"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
