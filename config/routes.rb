Rails.application.routes.draw do

  root 'static_pages#landing'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => { registrations: 'users/registrations' }
end
