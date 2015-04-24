# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'ellowtf_site'
set :repo_url, 'git@github.com:ello/ello-wtf.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/ellowtf_site
# set :deploy_to, '/var/www/ellowtf_site'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Rebuild Jekyll Site'
  task :rebuild_site do
    on roles(:web), in: :sequence do
      execute("cd #{current_path} && /usr/local/rvm/bin/rvm ruby-2.2.2@ellowtf do bundle exec jekyll build")
    end
  end

  after :finishing, :rebuild_site

end
