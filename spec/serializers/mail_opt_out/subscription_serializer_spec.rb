require 'rails_helper'

module MailOptOut
  RSpec.describe SubscriptionSerializer, type: :serializer do
    include_context 'with model user'
    include_context 'with an user'

    let(:subscription) { Fabricate.build(:subscription, user: user, list: list) }

    subject { described_class.new(subscription) }

    context 'with list' do
      let(:list) { nil }

      it do
        expect(subject.serializable_hash).to eql(
          {
            data: {
              attributes: {
                list: nil
            },
            id: nil,
            type: :subscription }
          }
        )
      end
    end

    context 'without list' do
      let(:list) { Fabricate.build(:list, name: 'Notification System') }

      it do
        expect(subject.serializable_hash).to eql(
          {
            data: {
              attributes: {
                list: 'Notification System'
            },
            id: nil,
            type: :subscription }
          }
        )
      end
    end
  end
end
