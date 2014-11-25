require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.ignore_hosts '127.0.0.1', 'localhost'
  c.cassette_library_dir = 'features/cassettes'
end

VCR.cucumber_tags do |t|
end
