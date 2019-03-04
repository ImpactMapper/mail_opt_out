require_dependency 'mail_opt_out/application_controller'

module MailOptOut
  class SubscriptionsController < ApplicationController
    before_action :set_user
    before_action :set_create_list, only: :subscribe
    before_action :set_list, only: :unsubscribe

    # GET /users/:user_id/subscriptions
    def index
      render jsonapi: Subscription.where({ user: @user }).all
    end

    # DELETE /users/:user_id/subscriptions/unsubscribe
    def unsubscribe
      subscription = Subscription.where({ user: @user, list: @list }).take!
      subscription.destroy

      head :no_content
    end

    # POST /users/:user_id/subscriptions/subscribe
    def subscribe
      subscription = Subscription.find_or_create_by({ user: @user, list: @list })

      if subscription.valid?
        render jsonapi: subscription, status: :created
      else
        render jsonapi_errors: subscription.errors, status: :unprocessable_entity
      end
    end

    private

    def set_create_list
      return if create_params[:list].blank?
      list(create_params[:list])
    end

    def set_list
      return if params[:list].blank?
      list(params[:list])
    end

    def list(name)
      @list = List.find_or_create_by!({ name: name })
    end

    def create_params
      params.require(:data).require(:attributes).permit(:list)
    end

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
