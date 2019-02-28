require 'fast_jsonapi'

module MailOptOut
  class MailListSubscriptionSerializer
    include FastJsonapi::ObjectSerializer

    attributes :list

    def opt_out
      true
    end
  end
end
