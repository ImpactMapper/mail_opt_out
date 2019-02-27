module MailOptOut
  class MailListSubscription < ApplicationRecord
    self.table_name = 'mail_list_subscriptions'
    belongs_to :user, polymorphic: true, optional: true
  end
end
