require 'nyulibraries/deploy/capistrano'
require 'figs'

Figs.load(stage: "staging")

set :app_title, "umbra"

namespace :rails_config do
  task :set_variables do
  end
end
namespace :rails_config do
  task :set_servers do
  end
end

set(:app_settings, true)
set(:scm_username, ENV['DEPLOY_SCM_USERNAME'])
set(:app_path, ENV['DEPLOY_PATH'])
set(:user, ENV['DEPLOY_USER'])
set(:deploy_to, "#{fetch(:app_path)}#{fetch(:application)}")

puts Figs.env.deploy_servers

#Figs.env.deploy_servers.each_with_index do |deploy_server, index|
#  primary_flag = (index === 1)
#  server deploy_server, :app, :web, :db, primary: primary_flag
#end