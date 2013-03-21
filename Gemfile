source 'https://rubygems.org'

gem 'rails', '~> 3.2.13'

gem 'mysql2', "~> 0.3.11"

gem 'json', "~> 1.7.7"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'compass-rails', '~> 1.0.0'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'compass-susy-plugin', '~> 0.9.0'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', "~> 0.11.4", :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'yui-compressor', "~> 0.9.6"
end

group :development, :test do
  gem 'debugger'
  gem 'progress_bar'
  gem 'sunspot_solr'
  gem 'coveralls', "~> 0.6.2", :require => false
  gem "vcr", "~> 2.4.0"
  gem "webmock", "~> 1.11.0"
end

group :development do 
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  #Testing coverage
  gem 'simplecov', :require => false
  gem 'simplecov-rcov', :require => false
  #gem 'ruby-prof' #For Benchmarking
end

gem 'authpds-nyu', "~> 0.2.5"
gem 'jquery-rails', "~> 2.2.1"

# Deploy with Capistrano
gem 'rvm-capistrano', "~> 1.2.7"
gem 'sunspot_rails', "~> 2.0.0"
gem 'acts-as-taggable-on', '~> 2.3.1'

gem "rails_config", "~> 0.3.2"

# Background jobs
gem 'delayed_job_active_record', "~> 0.4.3"
gem 'daemons', "~> 1.1.9"

#gem 'blacklight', :path => '/apps/blacklight'
gem 'blacklight', '~> 4.1.0'

#gem 'nyulibraries_assets', :path => '/apps/nyulibraries_assets'
gem 'nyulibraries_assets', :git => 'git://github.com/NYULibraries/nyulibraries_assets.git', :tag => "v1.0.5-no-bootstrap-sass-dep"

gem 'unicode', "~> 0.4.3" #optionally used by blacklight
gem 'mustache-rails', "~> 0.2.3", :require => 'mustache/railtie'

# For memcached
gem 'dalli', "~> 2.6.2"

gem 'newrelic_rpm', "~> 3.5.0"

gem "comma", "~> 3.0.4"
