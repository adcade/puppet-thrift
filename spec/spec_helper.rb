require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |config|
  config.tty = true
  config.mock_with :rspec
  config.raise_errors_for_deprecations!
end
