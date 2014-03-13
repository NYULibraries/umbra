require 'nyulibraries/deploy/capistrano'
require 'figs'
# Load up our figs
Figs.load(stage: fetch(:rails_env))

set :app_title, "umbra"
set :recipient, "web.services@library.nyu.edu"