require 'rails_helper'

module MailOptOut
  RSpec.describe SubscriptionsController, type: :request do
    include_context 'with model user'

    describe 'GET /users/:user_id/subscriptions' do
      let(:params) { {} }

      subject do
        # routes(Engine.routes, '/')
        # get(user_subscriptions_path(user_id: user_id), params: params)
        get "/users/#{user_id}/subscriptions", params: params
      end

      context 'without an user' do
        let(:user_id) { rand(100) }
        it { expect(subject).to eql(404) }
      end

      context 'with an user' do
        include_context 'with a subscription'

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
                'type' => 'subscription',
                'attributes' => {
                  'list' => 'Notification System'
                 }
              }
            )
          end
        end
      end
    end

    describe 'POST /users/:user_id/subscriptions/subscribe' do
      include_context 'with an user'

      let(:params)  { {} }

      subject do
        # routes(Engine.routes, '/')
        # post(subscribe_user_subscriptions_path(user_id: user_id), params: params)
        post "/users/#{user_id}/subscriptions/subscribe", params: params
      end

      context 'without a payload' do
        it do
          expect(subject).to eql(422)
          expect(response_json['errors'][0]['detail'])
            .to eq('Param is missing or the value is empty: data')
        end
      end

      context 'with a payload' do
        let(:params) do
          {
            data: {
              attributes: {
                list: list_name
              }
            }
          }
        end

        context 'with a list' do
          let(:list_name) { 'Notification System' }

          it do
            expect(subject).to eql(201)
            expect(response_json['data'])
              .to have_attribute(:list).with_value('Notification System')
          end
        end

        context 'without a list' do
          let(:list_name) { nil }

          it do
            expect(subject).to eql(201)
            expect(response_json['data'])
              .to have_attribute(:list).with_value('Default List')
          end
        end
      end
    end

    describe 'DELETE  /users/:user_id/subscriptions/unsubscribe' do
      include_context 'with an user'

      let(:params)  { {} }

      subject do
        # routes(Engine.routes, '/')
        # post(unsubscribe_user_subscriptions_path(user_id: user_id), params: params)
        delete "/users/#{user_id}/subscriptions/unsubscribe", params: params
      end

      context 'without a subscription' do
        it do
          expect {
            expect(subject).to eql(404)
          }.to_not change {
            Subscription.count
          }
        end
      end

      context 'with a subscription' do
        include_context 'with a subscription'

        let(:params)  { { list:  'Notification System' } }

        it do
          expect {
            expect(subject).to eql(204)
          }.to change {
            Subscription.count
          }.by(-1)
        end
      end
    end
  end
end
