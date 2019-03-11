module MailOptOut
  class Subscription < ApplicationRecord
    belongs_to :user, polymorphic: true
    belongs_to :list, -> { where published: true }, class_name: 'MailOptOut::List'
  end
end
