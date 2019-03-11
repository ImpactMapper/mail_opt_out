require 'rails_helper'

module MailOptOut
  RSpec.describe ListSerializer, type: :serializer do
    let(:list) { Fabricate.build(:list, name: 'Notification System', number: '42x', description: 'description') }

    subject { described_class.new(list) }

    it do
      expect(subject.serializable_hash).to eql(
        {
          data: {
            attributes: {
              name: 'Notification System',
              number: '42x',
              description: 'description'
          },
         id: nil,
         type: :list }
        })
    end
  end
end
