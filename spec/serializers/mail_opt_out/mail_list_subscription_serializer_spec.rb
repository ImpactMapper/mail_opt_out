require 'rails_helper'

module MailOptOut
  RSpec.describe MailListSubscriptionSerializer, type: :serializer do
    with_model :User do
      table do |t|
        t.string :name
        t.string :email
        t.timestamps
      end

      model do
        validates :email, presence: true
      end
    end

    let(:user) do
      User.create!({
        name:  FFaker::Name.name,
        email: FFaker::Internet.email
      })
    end
    let(:mail_list_subscription) { Fabricate.build(:mail_list_subscription, user: user, list: 'Notification System') }

    subject { described_class.new(mail_list_subscription) }

    it do
      expect(subject.serializable_hash).to eql(
        {
          data: {
            attributes: {
              list: 'Notification System'
          },
         id: nil,
         type: :mail_list_subscription }
        })
    end
  end
end
