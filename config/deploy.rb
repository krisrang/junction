require 'bundler/setup'
require 'bundler/capistrano'
require 'meow-deploy'

set :application,         'junction'
set :repository,          'git@github.com:krisrang/junction.git'
set :domain,              'meow.kristjanrang.eu'
set :applicationdir,      '/home/deploy/sites/junction'
set :user,                'deploy'
set :use_sudo,            false

set :scm, :git
set :branch, "master"

role :web, domain
role :app, domain
role :db, domain, primary: true

set :deploy_to, applicationdir
set :deploy_via, :remote_cache

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:port] = 24365

after 'deploy:create_symlink', 'secrets:upload', 'secrets:symlink'
after 'deploy:restart', 'god:reload', 'god:restart'
