require 'rails_helper'

module MailOptOut
  RSpec.describe SubscriptionSerializer, type: :serializer do
    include_context 'with model user'
    include_context 'with an user'

    let(:subscription) { Fabricate.build(:subscription, user: user, list: 'Notification System') }

    subject { described_class.new(subscription) }

    it do
      expect(subject.serializable_hash).to eql(
        {
          data: {
            attributes: {
              list: 'Notification System'
          },
         id: nil,
         type: :subscription }
        })
    end
  end
end
