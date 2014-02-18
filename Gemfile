source 'https://rubygems.org'

gem 'rails', '~> 3.2.17'

gem 'mysql2', '~> 0.3.11'

gem 'json', '~> 1.8.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'compass-rails', '~> 1.0.0'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'compass-susy-plugin', '~> 0.9.0'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', '~> 0.12.0', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'yui-compressor', '~> 0.12.0'
end

group :development do 
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'sunspot_solr'
  gem 'progress_bar'
end

group :test do
  #Testing coverage
  gem 'simplecov', :require => false
  gem 'simplecov-rcov', :require => false
  #gem 'ruby-prof' #For Benchmarking
  gem 'coveralls', '~> 0.7.0', :require => false
  gem 'vcr', '~> 2.6.0'
  gem 'webmock', '~> 1.15.0'
end

gem 'debugger', :groups => [:development, :test]

gem 'jquery-rails', '~> 3.0.4'
gem 'jquery-ui-rails', '~> 4.1.0'

gem 'sunspot_rails', '~> 2.0.0'
gem 'acts-as-taggable-on', '~> 2.4.1'

gem 'rails_config', '~> 0.3.3'

gem 'blacklight', '~> 4.2.2'
#gem 'blacklight', '~> 4.4.2'

gem 'authpds-nyu', :git => 'git://github.com/NYULibraries/authpds-nyu.git', :tag => 'v1.1.2'
gem 'nyulibraries_assets', :git => 'git://github.com/NYULibraries/nyulibraries_assets.git', :tag => 'v1.2.0'
gem 'nyulibraries-deploy', :git => 'git://github.com/NYULibraries/nyulibraries-deploy.git', :tag => 'v4.0.0'

gem 'unicode', '~> 0.4.3' #optionally used by blacklight

gem 'mustache', '0.99.4'
gem 'mustache-rails', '~> 0.2.3', :require => 'mustache/railtie'

# For memcached
gem 'dalli', '~> 2.6.4'

gem 'newrelic_rpm', '~> 3.6.0'

gem 'comma', '~> 3.2.0'