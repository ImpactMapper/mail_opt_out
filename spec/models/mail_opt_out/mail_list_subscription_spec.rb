require 'rails_helper'

module MailOptOut
  RSpec.describe MailListSubscription, type: :model do
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

    context do
      let(:user) do
        User.create!({
          name:  FFaker::Name.name,
          email: FFaker::Internet.email
        })
      end
      let(:mail_list_subscription) { Fabricate.build(:mail_list_subscription, user: user) }
      it do
        expect(mail_list_subscription).to be_valid
        expect {
          mail_list_subscription.save!
        }.to_not raise_error
      end
    end
  end
end
