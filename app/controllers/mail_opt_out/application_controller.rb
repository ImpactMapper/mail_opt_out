require 'jsonapi'

module MailOptOut
  class ApplicationController < ActionController::API
    include JSONAPI::Errors
    include JSONAPI::Filtering

    [
      ActionController::ParameterMissing,
    ].each do |exception_class|
      rescue_from exception_class do |exception|
        error = {
          status: '422',
          title: Rack::Utils::HTTP_STATUS_CODES[422],
          detail: exception.message.humanize
        }
        render jsonapi_errors: [error], status: :unprocessable_entity
      end
    end


    [
      ActiveRecord::RecordNotFound,
    ].each do |exception_class|
      rescue_from exception_class do |exception|
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
end
