$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'flicket'
require 'pry'
require 'vcr'

def spec_folder
  File.expand_path('../', __FILE__)
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.configure_rspec_metadata!
end

RSpec.configure do |c|
  c.filter_run_including focus: true
  c.run_all_when_everything_filtered = true
end
