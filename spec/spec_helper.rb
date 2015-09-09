require 'simplecov'
require 'simplecov-rcov'
require 'coveralls'

SimpleCov.merge_timeout 3600
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::RcovFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

ENV["RAILS_ENV"] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'vcr'
require 'database_cleaner'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

def csv_fixture(filename, content_type = "text/csv")
  file = File.new(File.join(File.dirname(__FILE__), 'fixtures', 'csv', filename))
  csv_fixture = ActionDispatch::Http::UploadedFile.new(tempfile: file, filename: File.basename(file))
  csv_fixture.content_type = content_type
  return csv_fixture
end

if Rails.env.test?
  begin
    WebMock.allow_net_connect!
    Sunspot.remove_all(Umbra::Record)
  ensure
    WebMock.disable_net_connect!
  end
end

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    # Startout by trucating all the tables
    DatabaseCleaner.clean_with :truncation
    # Then use transactions to roll back other changes
    DatabaseCleaner.strategy = :transaction

    # Run factory girl lint before the suite
    begin
      DatabaseCleaner.start
      # FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end

  config.around(:each) do |example|
    DatabaseCleaner.start
    example.run
    DatabaseCleaner.clean
  end

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  Dir[Rails.root.join("features/support/helpers/**/*.rb")].each do |helper|
    require helper
    helper_name = "UmbraFeatures::#{helper.camelize.demodulize.split('.').first}"
    config.include helper_name.constantize
  end
end

VCR.configure do |c|
  c.ignore_localhost = true
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.configure_rspec_metadata!
  c.hook_into :webmock
end
