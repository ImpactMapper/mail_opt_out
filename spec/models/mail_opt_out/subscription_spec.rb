require 'rails_helper'

module MailOptOut
  RSpec.describe Subscription, type: :model do
    include_context 'with model user'

    context do
      include_context 'with an user'

      let(:subscription) { Fabricate.build(:subscription, user: user) }

      it do
        expect(subscription).to be_valid
        expect {
          subscription.save!
        }.to_not raise_error
      end
    end
  end
end
