require 'rails_helper'

module MailOptOut
  RSpec.describe List, type: :model do
    let(:list) { Fabricate.build(:list) }

    it do
      expect(list).to be_valid
      expect {
        list.save!
      }.to_not raise_error
    end
  end
end
