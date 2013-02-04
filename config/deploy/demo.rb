server "rubyfatt-demo.kreations.it", :web, :app, :db, primary: true

set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache

set :branch, "fatture"
set :rails_env, "production"
set :asset_env, "RAILS_GROUPS=assets"

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      if command == "start"
        sudo "/usr/bin/svc -u /etc/service/rubyfatt"
      elsif command == "stop"
        sudo "/usr/bin/svc -d /etc/service/rubyfatt"
      else
        sudo "/usr/bin/svc -t /etc/service/rubyfatt"
      end
    end
  end

  task :prepare_install do
    run "ln -nfs #{shared_path}/public/images/ #{release_path}/public/"
    run "ln -nfs #{shared_path}/public/javascripts/ #{release_path}/public/"
    run "ln -nfs #{shared_path}/public/stylesheets/ #{release_path}/public/"
  end
  before "deploy:finalize_update", "deploy:prepare_install"

  namespace :assets do
    task :precompile, roles: :web, except: {no_release: true} do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end

  task :create_symlink do
    run "ln -nfs #{shared_path}/system/ #{release_path}/"
    run "rm -f #{current_path} && ln -s #{release_path} #{current_path}"
  end

  task :setup_config, roles: :app do
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/#{branch}`
      puts "WARNING: HEAD is not the same as origin/#{branch}"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end

