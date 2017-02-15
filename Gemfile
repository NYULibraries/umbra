source 'https://rubygems.org'

gem 'rails', '~> 4.2.7.1'
gem 'mysql2', '~> 0.4.5'
gem 'json', '~> 1.8.0'
gem 'jquery-rails', '~> 4.2.2'
gem 'jquery-ui-rails', '~> 6.0.0'
gem 'sunspot_rails', '~> 2.2.0'
gem 'acts-as-taggable-on', '~> 3.4.2'
gem 'acts_as_indexed', '~> 0.8.3'
# gem 'nyulibraries-assets', github: 'NYULibraries/nyulibraries-assets', tag: 'v4.4.3'
gem 'nyulibraries_stylesheets', github: 'NYULibraries/nyulibraries_stylesheets', tag: 'v1.0.1'
gem 'nyulibraries_templates', github: 'NYULibraries/nyulibraries_templates', tag: 'v1.0.1'
gem 'nyulibraries_institutions', github: 'NYULibraries/nyulibraries_institutions', tag: 'v1.0.1'
gem 'nyulibraries_javascripts', github: 'NYULibraries/nyulibraries_javascripts', tag: 'v1.0.0'
gem 'nyulibraries_errors', github: 'NYULibraries/nyulibraries_errors', tag: 'v1.0.1'
gem 'formaggio', github: 'NYULibraries/formaggio', tag: 'v1.5.2'
gem 'unicode', '~> 0.4.4'
gem 'dalli', '~> 2.7.0'
gem 'newrelic_rpm', '~> 3'
gem 'comma', '~> 3.2.0'
gem 'blacklight', '~> 5.19.2'

gem 'omniauth-nyulibraries', github: 'NYULibraries/omniauth-nyulibraries',  tag: 'v2.1.1'
gem 'devise', '~> 4.2.0'

gem 'sass-rails', '~> 5.0.6'
gem 'compass-rails', '~> 2.0.5'
gem 'coffee-rails', '~> 4.2.0'
gem 'therubyracer', '~> 0.12.0', platforms: :ruby
gem 'uglifier', '~> 3.0.4'

gem 'foreman', '~> 0.83'

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
  gem 'factory_girl_rails', '~> 4.8.0'
  # Use pry-debugger as the REPL and for debugging
  gem 'pry', '~> 0.10.1'
end

group :test, :cucumber do
  gem 'cucumber-rails', require: false
  gem 'cucumber', '~> 2.4.0'
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
  gem 'coveralls', '~> 0.8.0', require: false
  gem 'vcr', '~> 3.0.0'
  gem 'webmock', '~> 2.3.2'
  gem 'selenium-webdriver', '~> 3.1.0'
  gem 'database_cleaner', '~> 1.5.0'
end

gem 'sunspot_solr', '~> 2.2.7', group: [:test, :development]
