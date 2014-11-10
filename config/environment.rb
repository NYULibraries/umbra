# Load the Rails application.
require File.expand_path('../application', __FILE__)

ActionMailer::Base.default :from => 'no-reply@library.nyu.edu'

# Initialize the Rails application.
Rails.application.initialize!
