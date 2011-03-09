$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
require 'param_checker'

#load(File.dirname(__FILE__) + '/models.rb')

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.filter_run_excluding :exclude => true

  config.mock_with :rspec
end
