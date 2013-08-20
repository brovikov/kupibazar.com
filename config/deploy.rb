#=== REQUIRE ===#
#require 'rvm/capistrano'
#set :rvm_type,        :user
set :rvm_ruby_string, '1.9.2'

require 'bundler/capistrano'


#=== SETTINGS ===#
set :application, "test-app"
set :deploy_to,   "/rails-app/#{application}"

set :domain, "firehost.com.ua"
set :user,   "c00049"

set :rails_env, "production"

server domain, :web, :app, :db, primary: true

set :use_sudo, false
set :keep_releases, 10

set :shared_children, shared_children + %w{public/uploads}

set :scm,                   :git
set :branch,                "master"
set :deploy_via,            :export
set :git_enable_submodules, 1
set :repository,            "git@github.com:brovikov/test_app.git"
set :local_repository,      "ssh://#{user}@#{domain}/git/#{application}.git"

#git@github.com:brovikov/test_app.git
#=== TASKS ===#
#before 'deploy:setup', 'rvm:install_ruby'

#after 'deploy:update_code', :roles => :app do
#  run "rm -f #{current_release}/config/database.yml"
#  run "ln -s #{deploy_to}/shared/config/database.yml #{current_release}/config/database.yml"
#  run "sudo chown -R $(whoami):www-data #{deploy_to}"
#end

after 'deploy', 'deploy:migrate', 'deploy:cleanup'

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
#  task :force_restart do
#    run "sudo /etc/init.d/unicorn_dobroserver stop"
#    run "sudo /etc/init.d/unicorn_dobroserver start"
#  end
#  task :start do
#    run "sudo /etc/init.d/unicorn_dobroserver start"
#  end
#  task :stop do
#    run "sudo /etc/init.d/unicorn_dobroserver stop"
#  end
end