module MailOptOut
  class Subscription < ApplicationRecord
    belongs_to :user, polymorphic: true, optional: true
    belongs_to :list, class_name: 'MailOptOut::List'
  end
end
