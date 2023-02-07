Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#landing'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


end
