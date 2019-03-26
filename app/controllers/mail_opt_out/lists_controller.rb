require_dependency 'mail_opt_out/application_controller'

module MailOptOut
  class ListsController < ApplicationController
    # GET /lists
    def index
      allowed = [:published]

      jsonapi_filter(List.all, allowed) do |filtered|
        render jsonapi: filtered.result
      end
    end

    def show
      render jsonapi: List.active.where({ id: params[:id] }).take!
    end

    def create
      list = List.new(create_params)

      if list.save
        render jsonapi: list, status: :created
      else
        render jsonapi_errors: list.errors, status: :unprocessable_entity
      end
    end

    def update
      list = List.active.where({ id: params[:id] }).take!

      if list.update(update_params)
        render jsonapi: list, status: :ok
      else
        render jsonapi_errors: list.errors, status: :unprocessable_entity
      end
    end

    def destroy
      list = List.where({ id: params[:id] }).take!
      list.destroy

      head :no_content
    end

    private

    def create_params
      params.require(:data).require(:attributes).permit(:name, :number, :description, :published)
    end
    alias_method :update_params, :create_params
  end
end
