require 'capistrano-nyu'

set :app_title, "umbra"
set :application, "#{app_title}_repos"

# Git vars
set :repository, "git@github.com:NYULibraries/umbra.git"