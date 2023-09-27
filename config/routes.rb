Rails.application.routes.draw do
  root to: "home#index" 

  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_scope :user do
    post 'users/events', to: 'users/events#create'
  end
end
