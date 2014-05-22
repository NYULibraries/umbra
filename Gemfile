source 'https://rubygems.org'

gem 'rails', '~> 3.2.18'
gem 'mysql2', '~> 0.3.0'
gem 'json', '~> 1.8.0'
gem 'jquery-rails', '~> 3.1.0'
gem 'jquery-ui-rails', '~> 4.2.0'
gem 'sunspot_rails', '~> 2.1.0'
gem 'acts-as-taggable-on', '~> 3.2.3'
gem 'authpds-nyu', :git => 'git://github.com/NYULibraries/authpds-nyu.git', :tag => 'v1.1.2'
gem 'nyulibraries-assets', :git => 'git://github.com/NYULibraries/nyulibraries-assets.git', :tag => 'v3.0.3'
gem 'nyulibraries-deploy', :git => 'git://github.com/NYULibraries/nyulibraries-deploy.git', :branch => 'development-fig' #:tag => 'v4.0.0'
gem 'unicode', '~> 0.4.4.1'
gem 'mustache', '0.99.4'
gem 'mustache-rails', github: 'josh/mustache-rails', require: 'mustache/railtie'
gem 'dalli', '~> 2.7.0'
gem 'newrelic_rpm', '~> 3.8.0'
gem 'comma', '~> 3.2.0'
gem 'blacklight', '~> 4.7.0'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'compass-rails', '~> 1.0.0'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'compass-susy-plugin', '~> 0.9.0'
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
  gem 'simplecov', :require => false
  gem 'simplecov-rcov', :require => false
  gem 'coveralls', '~> 0.7.0', :require => false
  gem 'vcr', '~> 2.8.0'
  gem 'webmock', '~> 1.17.4'
  gem 'database_cleaner', '~> 1.2.0'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'rspec-rails', '~> 2.14.2'
end

gem 'pry-debugger', '~> 0.2.2', :group => [:test, :development]
