module MailOptOut
  class List < ApplicationRecord
    validates :name, presence: true
    validates_uniqueness_of :name, case_sensitive: false
    scope :active, -> { where(published: true) }
  end
end
