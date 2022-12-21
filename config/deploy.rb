# frozen_string_literal: true

set :application, 'movie_collector'
set :repository,  'git@github.com:invalidusrname/movie-collector.git'
# NOTE: use these settings when github goes down
# set :repository, '/home/deploy/projects/movie_collector'
# set :local_repository, "."
set :scm, :git
set :rake, '/opt/ree/bin/rake'
set :user, 'inali'
set :use_sudo, false
set :user, 'deploy'

set :deploy_to, "/home/#{user}/www/#{application}"

role :app, 'moviecollector.org'
role :web, 'moviecollector.org'
role :db,  'moviecollector.org', primary: true

task :ruby_info, roles: :app do
  run 'gem env'
  run 'ruby -v'
end

namespace :mod_rails do
  desc <<-DESC
  Restart the application altering tmp/restart.txt for mod_rails.
  DESC
  task :restart, roles: :app do
    run "touch  #{release_path}/tmp/restart.txt"
  end
end

namespace :deploy do
  %w[start restart].each { |name| task name, roles: :app do mod_rails.restart end }
end

namespace :db do
  desc 'Make symlink for database yaml'
  task :symlink do
    ['database.yml', 'facebooker.yml', 'newrelic.yml',
     'amazonrc.txt', 'config.yml', 'twitter_auth.yml'].each do |name|
      run "ln -nfs #{shared_path}/#{name} #{release_path}/config/#{name}"
    end
    ['googleef5e9facdc286530.html'].each do |seo_file|
      run "ln -nfs #{shared_path}/#{seo_file} #{release_path}/public/#{seo_file}"
    end
  end
end

# http://gist.github.com/45318
namespace :deploy do
  desc 'Make sure there is something to deploy'
  task :check_revision, roles: [:web] do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      Rails.logger.debug ''
      Rails.logger.debug "  \033[1;33m**************************************************\033[0m"
      Rails.logger.debug "  \033[1;33m* WARNING: HEAD is not the same as origin/master *\033[0m"
      Rails.logger.debug "  \033[1;33m**************************************************\033[0m"
      Rails.logger.debug ''
      exit
    end
  end
end

# http://gist.github.com/237699
# namespace :deploy do
#   desc 'Bundle and minify the JS and CSS files'
#   task :precache_assets, :roles => :app do
#     root_path    = File.expand_path(File.dirname(__FILE__) + '/..')
#     jammit_path  = Dir["#{root_path}/vendor/gems/jammit-*/bin/jammit"].first
#     yui_lib_path = Dir["#{root_path}/vendor/gems/yui-compressor-*/lib"].first
#     assets_path  = "#{root_path}/public/assets"
#
#     # Precaching assets
#     run_locally "ruby -I#{yui_lib_path} #{jammit_path}"
#     # Uploading prechached assets
#     top.upload assets_path, "#{current_release}/public", :via => :scp, :recursive => true
#   end
# end

before  'deploy', 'deploy:check_revision'

after   'deploy:update_code', 'db:symlink'
after   'deploy:update_code', 'assets:compile'
