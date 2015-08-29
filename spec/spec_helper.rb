$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
require 'ukrainian'
include Ukrainian

RSpec.configure do |config|
  config.default_formatter = :doc if config.files_to_run.one?
  config.mock_with :rspec
end
