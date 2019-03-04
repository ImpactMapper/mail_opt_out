module MailOptOut
  class Subscription < ApplicationRecord
    self.table_name = 'subscriptions'
    belongs_to :user, polymorphic: true, optional: true
  end
end
