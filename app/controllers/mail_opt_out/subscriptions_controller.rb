require_dependency 'mail_opt_out/application_controller'

module MailOptOut
  class SubscriptionsController < ApplicationController
    before_action :set_user

    # GET /users/:user_id/subscriptions
    def index
      render jsonapi: MailListSubscription.where({ user: @user }).all
    end

    def unsubscribe
    end

    def subscribe
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
