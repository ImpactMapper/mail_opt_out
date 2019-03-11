module MailOptOut
  class List < ApplicationRecord
    validates :name, presence: true
    scope :active, -> { where(published: true) }
  end
end
