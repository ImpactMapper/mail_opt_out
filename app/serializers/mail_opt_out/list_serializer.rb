require 'fast_jsonapi'

module MailOptOut
  class ListSerializer
    include FastJsonapi::ObjectSerializer

    attribute :name, :number
  end
end
