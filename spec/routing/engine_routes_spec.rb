require 'rails_helper'

module MailOptOut
  RSpec.describe SubscriptionsController, type: :routing do
    routes { Engine.routes }

    let(:user_id) { rand(100) }

    it 'routes to the list of all subscriptions' do
      expect(get: user_subscriptions_path(user_id: user_id)).
        to route_to({
          'format'     => :jsonapi,
          'controller' => 'mail_opt_out/subscriptions',
          'action'     => 'index',
          'user_id'    => "#{user_id}"
        })
    end

    it 'routes to the subscribe' do
      expect(post: subscribe_user_subscriptions_path(user_id: user_id)).
        to route_to({
          'format'     => :jsonapi,
          'controller' => 'mail_opt_out/subscriptions',
          'action'     => 'subscribe',
          'user_id'    => "#{user_id}"
        })
    end

    it 'routes to the unsubscribe' do
      expect(delete: unsubscribe_user_subscriptions_path(user_id: user_id)).
        to route_to({
          'format'     => :jsonapi,
          'controller' => 'mail_opt_out/subscriptions',
          'action'     => 'unsubscribe',
          'user_id'    => "#{user_id}"
        })
    end
  end
end
