module MailOptOut
  class Engine < ::Rails::Engine
    isolate_namespace MailOptOut
    config.generators.api_only = true
  end
end
