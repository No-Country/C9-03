Rails.application.routes.draw do
  root 'static_pages#landing'
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  # Allows us to use link_to for session destroy
  devise_scope :user do
    get "/users/sign_out", as: "sign_out", to: "devise/sessions#destroy"
  end
end
