require 'capistrano-nyu'

set :ssh_options, {:forward_agent => true}
set :app_title, "umbra"
set :application, "#{app_title}_repos"

# RVM  vars
set :rvm_ruby_string, "1.9.3-p448"

# Git vars
set :repository, "git@github.com:NYULibraries/umbra.git" 

# Rails specific vars
set :normalize_asset_timestamps, false

set :recipient, "web.services@library.nyu.edu"