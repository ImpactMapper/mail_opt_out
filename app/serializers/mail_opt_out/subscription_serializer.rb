require 'fast_jsonapi'

module MailOptOut
  class SubscriptionSerializer
    include FastJsonapi::ObjectSerializer

    attribute :list do |object|
      object.list&.name
    end

    def opt_in
      true
    end
  end
end
