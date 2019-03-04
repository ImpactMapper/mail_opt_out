module MailOptOut
  class Subscription < ApplicationRecord
    belongs_to :user, polymorphic: true, optional: true
  end
end
