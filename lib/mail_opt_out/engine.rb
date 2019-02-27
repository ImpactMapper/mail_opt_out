module MailOptOut
  class Engine < ::Rails::Engine
    isolate_namespace MailOptOut
    config.generators.api_only = true
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
