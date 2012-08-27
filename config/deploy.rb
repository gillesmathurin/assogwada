# -*- encoding : utf-8 -*-
set :application, "annuaire"
set :user, "root"
set :domain, '208.88.125.46'
set :server_hostname, '208.88.125.46'

set :git_account, 'gillesmathurin'

set :scm, "git"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :app, server_hostname
role :web, server_hostname
role :db, server_hostname, :primary => true

default_run_options[:pty] = true
set :repository, "git@github.com:#{git_account}/assogwada.git"
set :user, user

ssh_options[:forward_agent] = true
set :branch, 'release'
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
# set :git_enable_submodules, 1
set :use_sudo, false
set :deploy_to, "/var/rails/annuaire"

namespace :delayed_job do
  def rails_env
    fetch(:rails_env, false) ? "RAILS_ENV=#{fetch(:rails_env)}" : ''
  end
  
  desc "Stop the delayed_job process"
  task :stop, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=production script/delayed_job stop"
  end

  desc "Start the delayed_job process"
  task :start, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=production script/delayed_job start"
  end

  desc "Restart the delayed_job process"
  task :restart, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=production script/delayed_job restart"
  end
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
  
  task :finishing_touches, :roles => :app do
    run "cp -pf /var/rails/annuaire/to_copy/database.yml #{current_path}/config/database.yml"
    # run "cd #{current_path} && RAILS_ENV=production rake db:create"
  end
  
  task :set_to_wwwdata_user, :roles => :app do
    run "chown -R www-data:root /var/rails/annuaire"
    # run "chown -R www-data:root #{current_path}/log/production.log"
  end
  
  task :load_seeds_data, :role => :app do
    run "cd #{current_path} && rake db:seed RAILS_ENV=production"
  end
  
  desc "Update the crontab"
  task :update_crontab, :roles => :db do
    run "cd #{current_path} && RAILS_ENV=production whenever --update-crontab #{application}"
  end
end

after 'deploy:symlink', 'deploy:update_crontab', 'deploy:finishing_touches', 'deploy:migrate', 'deploy:set_to_wwwdata_user', 'delayed_job:restart'
  
# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
