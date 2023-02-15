Rails.application.routes.draw do
  root 'static_pages#landing'

  resources :stores, only: %i[index show]
end
