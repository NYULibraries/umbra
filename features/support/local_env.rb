require 'coveralls'
Coveralls.wear_merged!('rails')

require 'pry'

# Require support classes in spec/support and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each do |helper|
  require helper
end

# Require and include helper modules
# in feature/support/helpers and its subdirectories.
Dir[Rails.root.join("features/support/helpers/**/*.rb")].each do |helper|
  require helper
  # Only include _helper.rb methods
  if /_helper.rb/ === helper
    helper_name = "UmbraFeatures::#{helper.camelize.demodulize.split('.').first}"
    Cucumber::Rails::World.send(:include, helper_name.constantize)
  end
end

require 'capybara/poltergeist'

if ENV['IN_BROWSER']
  # On demand: non-headless tests via Selenium/WebDriver
  # To run the scenarios in browser (default: Firefox), use the following command line:
  # IN_BROWSER=true bundle exec cucumber
  # or (to have a pause of 1 second between each step):
  # IN_BROWSER=true PAUSE=1 bundle exec cucumber
  Capybara.register_driver :selenium do |app|
    http_client = Selenium::WebDriver::Remote::Http::Default.new
    http_client.timeout = 120
    Capybara::Selenium::Driver.new(app, :browser => :firefox, :http_client => http_client)
  end
  Capybara.default_driver = :selenium
  AfterStep do
    sleep (ENV['PAUSE'] || 0).to_i
  end
else
  # DEFAULT: headless tests with poltergeist/PhantomJS
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(
      app,
      phantomjs_options: ['--load-images=no', '--ignore-ssl-errors=yes'],
      window_size: [1280, 1024],
      timeout: 120#,
      # debug: true
    )
  end
  Capybara.default_driver    = :poltergeist
  Capybara.javascript_driver = :poltergeist
  # Capybara.default_wait_time = 20
end
