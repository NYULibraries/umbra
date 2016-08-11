source 'https://rubygems.org'

gem 'rails', '~> 4.2.7.1'
gem 'mysql2', '~> 0.3.0'
gem 'json', '~> 1.8.0'
gem 'jquery-rails', '~> 3.1.0'
gem 'jquery-ui-rails', '~> 5.0.2'
gem 'sunspot_rails', '~> 2.2.0'
gem 'acts-as-taggable-on', '~> 3.4.2'
gem 'acts_as_indexed', '~> 0.8.3'
# gem 'nyulibraries-assets', github: 'NYULibraries/nyulibraries-assets', tag: 'v4.4.3'
gem 'nyulibraries_stylesheets', github: 'NYULibraries/nyulibraries_stylesheets'
gem 'nyulibraries_templates', github: 'NYULibraries/nyulibraries_templates'
gem 'nyulibraries_javascripts', github: 'NYULibraries/nyulibraries_javascripts'
gem 'nyulibraries_errors', github: 'NYULibraries/nyulibraries_errors', tag: 'v1.0.0'
gem 'formaggio', github: 'NYULibraries/formaggio', tag: 'v1.5.2'
gem 'unicode', '~> 0.4.4.1'
gem 'mustache', '0.99.4'
gem 'mustache-rails', github: 'NYULibraries/mustache-rails', require: 'mustache/railtie'
gem 'dalli', '~> 2.7.0'
gem 'newrelic_rpm', '~> 3.9.6'
gem 'comma', '~> 3.2.0'
gem 'blacklight', '~> 5.7.0'

gem 'omniauth-nyulibraries', github: 'NYULibraries/omniauth-nyulibraries',  tag: 'v2.0.0'
gem 'devise', '~> 3.5.4'

gem 'sass-rails', '>= 5.0.0.beta1'
gem 'compass-rails', '~> 2.0.5'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer', '~> 0.12.0', platforms: :ruby
gem 'uglifier', '>= 2.5.3'

gem 'foreman', '~> 0.78.0'

group :development do
  gem 'better_errors', '~> 2.0.0'
  gem 'binding_of_caller', '~> 0.7.2'
end

group :development, :test, :cucumber do
  gem 'rspec-rails', '~> 2.14.0'
  # Phantomjs for headless browser testing
  gem 'phantomjs', '>= 1.9.0'
  gem 'poltergeist', '~> 1.10.0'
  # Use factory girl for creating models
  gem 'factory_girl_rails', '~> 4.4.0'
  # Use pry-debugger as the REPL and for debugging
  gem 'pry', '~> 0.10.1'
end

group :test, :cucumber do
  gem 'cucumber-rails', require: false
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
  gem 'coveralls', '~> 0.7.0', require: false
  gem 'vcr', '~> 2.9.3'
  gem 'webmock', '~> 1.19.0'
  gem 'selenium-webdriver', '~> 2.45.0'
  gem 'pickle', '~> 0.4.11'
  gem 'database_cleaner', '~> 1.3.0'
end

gem 'sunspot_solr', '~> 2.1.1', group: [:test, :development]
