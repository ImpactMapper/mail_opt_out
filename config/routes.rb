MailOptOut::Engine.routes.draw do
  resources :users, defaults: { format: :jsonapi } do
    resources :subscriptions, only: [:index] do
      collection do
        post :subscribe
        delete :unsubscribe
      end
    end
  end
end
