require_dependency 'mail_opt_out/application_controller'

module MailOptOut
  class SubscriptionsController < ApplicationController
    before_action :set_user

    # GET /users/:user_id/subscriptions
    def index
      render jsonapi: MailListSubscription.where({ user: @user }).all
    end

    # DELETE /users/:user_id/subscriptions/unsubscribe
    def unsubscribe
      subscription = MailListSubscription.where({ user: @user, list: params[:list] }).take!
      subscription.destroy

      head :no_content
    end

    # POST /users/:user_id/subscriptions/subscribe
    def subscribe
      subscription = MailListSubscription.find_or_create_by({ user: @user, list: create_params[:list] })

      if subscription.valid?
        render jsonapi: subscription, status: :created
      else
        render jsonapi_errors: subscription.errors, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end

    def create_params
      params.require(:data).require(:attributes).permit(:list)
    end
  end
end
