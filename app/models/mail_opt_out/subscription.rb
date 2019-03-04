module MailOptOut
  class Subscription < ApplicationRecord
    belongs_to :user, polymorphic: true, optional: true
    belongs_to :list, optional: true, class_name: 'MailOptOut::List'
  end
end
