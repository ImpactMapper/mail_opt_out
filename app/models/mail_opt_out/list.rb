module MailOptOut
  class List < ApplicationRecord
    validates :name, presence: true
  end
end
