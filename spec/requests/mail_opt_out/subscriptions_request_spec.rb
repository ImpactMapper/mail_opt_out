require 'rails_helper'

module MailOptOut
  RSpec.describe SubscriptionsController, type: :request do
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
    let(:user_id) { user.id }
    let!(:mail_list_subscription) { Fabricate.create(:mail_list_subscription, user: user, list: 'Notification System') }

    describe 'GET /users/:user_id/subscriptions' do
      let(:params) { {} }

      subject do
        routes(MailOptOut::Engine.routes, '/')
        get(user_subscriptions_path(user_id: user_id), params)
      end

      context 'with an user' do
        context 'returns the user' do
          context 'as an arbitrary user' do
            let(:user_id) { rand(100) }

            it do
              expect(subject).to eql(404)
              expect(response_json['errors'].size).to eql(1)
              expect(response_json['errors'][0]).to eql(
                {
                  'status' => '404',
                  'source' => 'User',
                  'title'  => 'Not Found',
                  'detail' => { 'id' => user_id.to_s }
                }
              )
            end
          end

          it do
            expect(subject).to eql(200)
            expect(response_json['data'].size).to eql(1)
            expect(response_json['data'][0]).to eql(
              {
                'id'   =>  user_id.to_s,
                'type' => 'mail_list_subscription',
                'attributes' => {
                  'list' => 'Notification System'
                 }
              }
            )
          end
        end
      end
    end
  end
end
