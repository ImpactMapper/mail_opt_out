require 'rspec/rails'

# Misc RSpec helpers.
module MailOptOut::RSpecHelpers
  # Helper to set the route set.
  #
  # @return [ActionDispatch::Routing::RouteSet]
  def routes(route_set, path)
    Rails.application.routes.draw do
      mount route_set, at: path
    end
  end

  # Helper to parse and return a deserialized JSON
  #
  # @return [Hash]
  def response_json
    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include MailOptOut::RSpecHelpers, type: :request
  config.include MailOptOut::Engine.routes.url_helpers, type: :request
end
