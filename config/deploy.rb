set :application, "fb_movie_collector"
set :repository,  "git@github.com:invalidusrname/movie_collector.git"
set :scm, :git
set :rake, '/opt/ruby-enterprise-1.8.6-20090610/bin/rake'
set :user, 'inali'
set :use_sudo, false
set :user, 'deploy'

set :deploy_to, "/home/#{user}/www/#{application}"

role :app, "moviecollector.org"
role :web, "moviecollector.org"
role :db,  "moviecollector.org", :primary => true

namespace :mod_rails do
  desc <<-DESC
  Restart the application altering tmp/restart.txt for mod_rails.
  DESC
  task :restart, :roles => :app do
    run "touch  #{release_path}/tmp/restart.txt"
  end
end

namespace :deploy do
  %w(start restart).each { |name| task name, :roles => :app do mod_rails.restart end }
end


namespace :db do
  desc "Make symlink for database yaml"
  task :symlink do
    ['database.yml', 'facebooker.yml', 'newrelic.yml', 
     'amazonrc.txt', 'config.yml'].each do |name|
      run "ln -nfs #{shared_path}/#{name} #{release_path}/config/#{name}"
    end
    ['googleef5e9facdc286530.html'].each do |seo_file|
      run "ln -nfs #{shared_path}/#{seo_file} #{release_path}/public/#{seo_file}"
    end
  end
end

after "deploy:update_code", "db:symlink"

namespace :assets do
  desc "Compiles stylesheets via compass"
  task :compile do
    run "cd #{current_path} && compass --force"
    run "cd #{current_path} && rake asset:packager:build_all"
  end
end

after "deploy:update_code", "assets:compile"
