Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root 'static_pages#landing'
    devise_for :users, :controllers => { registrations: 'users/registrations' }
    # Allows us to use link_to for session destroy
    devise_scope :user do
      get "/users/sign_out", as: "sign_out", to: "devise/sessions#destroy"
    end
    resources :stores, only: %i[index show]
    resources :locations, only: %i[index create]
    resource :shopping_cart, only: %i[show] do
      post 'add_food/:food_id(/:quantity)', action: :add_food, as: :add_food_to
      get 'checkout', action: :checkout, as: :checkout
      post 'remove_food/:food_id', action: :remove_food, as: :remove_food_from
    end
    resources :orders, only: %i[show] do
      post 'payment', action: :payment, as: :payment
    end
    # stripe webhooks
    mount StripeEvent::Engine, at: '/webhooks'
    post '/webhooks/stripe', to: 'webhooks#stripe'

    get "/success" => "static_pages#success"
  end
end
