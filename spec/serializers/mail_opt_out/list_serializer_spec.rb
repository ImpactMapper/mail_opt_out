require 'rails_helper'

module MailOptOut
  RSpec.describe ListSerializer, type: :serializer do
    let(:list) { Fabricate.build(:list, name: 'Notification System', number: '42x') }

    subject { described_class.new(list) }

    it do
      expect(subject.serializable_hash).to eql(
        {
          data: {
            attributes: {
              name: 'Notification System',
              number: '42x'
          },
         id: nil,
         type: :list }
        })
    end
  end
end
