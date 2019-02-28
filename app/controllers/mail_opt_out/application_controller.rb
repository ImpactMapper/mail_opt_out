require 'jsonapi'

module MailOptOut
  class ApplicationController < ActionController::API
    include JSONAPI::Errors

    # Not found (404) error handler callback
    #
    # @param exception [Exception] instance to handle
    # @return [String] JSONAPI error response
    def render_jsonapi_not_found(exception)
      error = {
        status: '404',
        title: Rack::Utils::HTTP_STATUS_CODES[404],
        source: exception&.model,
        detail: { id: exception&.id }

      }
      render jsonapi_errors: [error], status: :not_found
    end
  end
end
