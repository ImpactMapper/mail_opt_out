module MailOptOut
  class ServiceJob < ApplicationJob
    queue_as :default

    def perform(klass, method_name, attributes)
      hash = ActiveSupport::HashWithIndifferentAccess.new(attributes)
      klass.constantize.new.method(method_name).call(email: hash['email'], list_name: hash['list_name'])
    end
  end
end
