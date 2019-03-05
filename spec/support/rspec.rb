require 'rspec/rails'

RSpec::Matchers.define_negated_matcher :not_change, :change

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end
