require 'rspec/rails'

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end
