require 'dotenv-rails'
require 'jsonapi'

JSONAPI::Rails.install!

module MailOptOut
  class Engine < ::Rails::Engine
    isolate_namespace MailOptOut

    initializer 'mail_opt_out' do |app|
      MailOptOut.discover_services unless MailOptOut.services.any?
    end

    config.generators.api_only = true
    config.generators do |g|
      g.test_framework :rspec
    end

    # load envs
    Dotenv::Railtie.load
  end
end
