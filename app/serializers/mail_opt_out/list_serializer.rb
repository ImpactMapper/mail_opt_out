require 'fast_jsonapi'

module MailOptOut
  class ListSerializer
    include FastJsonapi::ObjectSerializer

    attribute :name, :number, :description
  end
end
