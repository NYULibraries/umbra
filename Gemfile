source 'https://rubygems.org'

gem 'rails', '~> 3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3'
gem 'mysql2', "~> 0.3.11"

gem 'json', "~> 1.7.5"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'compass-rails', '~> 1.0.0'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'compass-susy-plugin', '~> 0.9.0'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', "~> 0.10.0", :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'yui-compressor', "~> 0.9.6"
end

group :development do
  gem 'debugger'
  gem 'progress_bar'
  gem 'sunspot_solr'
end

group :test do
  gem 'debugger'
  gem 'sunspot_solr'
  #Testing coverage
  gem 'simplecov', :require => false
  gem 'simplecov-rcov', :require => false
  gem 'ruby-prof' #For Benchmarking
end

gem 'authpds-nyu', "~> 0.2.5"
gem 'jquery-rails', "~> 2.1.4"
# Deploy with Capistrano
gem 'rvm-capistrano', "~> 1.2.7"
gem 'sunspot_rails', "~> 1.3.3"
gem 'acts-as-taggable-on', '~> 2.3.1'

gem "rails_config", "~> 0.3.2"

#gem 'blacklight', :path => '/apps/blacklight'
#gem 'blacklight', :git => 'git://github.com/projectblacklight/blacklight.git'
#gem 'blacklight', :git => 'git://github.com/barnabyalter/blacklight.git'
gem 'blacklight', '~> 4.0.1'

#gem 'nyulibraries_assets', :path => '/apps/nyulibraries_assets'
gem 'nyulibraries_assets', :git => 'git://github.com/barnabyalter/nyulibraries_assets.git'
#gem 'nyulibraries_assets', :git => 'git://github.com/NYULibraries/nyulibraries_assets.git'

gem 'unicode', "~> 0.4.3" #optionally used by blacklight
gem 'mustache-rails', "~> 0.2.3", :require => 'mustache/railtie'

# For memcached
gem 'dalli', "~> 2.5.0"
