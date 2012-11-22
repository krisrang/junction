require 'bundler/setup'
require 'bundler/capistrano'
require 'meow-deploy'

set :application,         'junction'
set :repository,          'ssh://git@git.kristjanrang.eu:24365/junction.git'
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

set :default_environment, {
  'PATH' => 
  "/home/#{user}/.rbenv/shims:/home/#{user}/.rbenv/bin:$PATH"
}

namespace :sync do
  desc "Update 3rd party syncs"
  task :update do
    run "cd #{current_path}; bundle exec rake sync:update RAILS_ENV=production"
  end
end

after 'deploy:create_symlink', 'secrets:upload', 'secrets:symlink'
after 'deploy:restart', 'god:reload', 'god:restart', 'sync:update'
