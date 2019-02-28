require 'rails_helper'

module MailOptOut
  RSpec.describe MailOptOut::SubscriptionsController, type: :routing do
    routes { MailOptOut::Engine.routes }

    let(:user_id) { rand(100) }

    it 'routes to the list of all widgets' do
      expect(get: user_subscriptions_path(user_id: user_id)).
        to route_to({
          'format'     => :jsonapi,
          'controller' => 'mail_opt_out/subscriptions',
          'action'     => 'index',
          'user_id'    => "#{user_id}"
        })
    end
  end
end
