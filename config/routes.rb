Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end

  resources :foods, except: %i[show]
  
  resources :users, only: %i[index show]
  
  root 'users#index'
  get "up" => "rails/health#show", as: :rails_health_check
end
