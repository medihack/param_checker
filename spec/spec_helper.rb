$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
require 'param_checker'
require 'param_checker/hash_ext'

load(File.dirname(__FILE__) + '/model.rb')

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.filter_run_excluding :exclude => true

  config.mock_with :rspec
end
