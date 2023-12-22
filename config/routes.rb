Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end

  resources :foods, except: %i[show]
  
  resources :users, only: %i[index show]
  resources :public_recipes, only: [:index]
  resources :recipes, only: %i[index show create destroy] do
    member do
      patch 'update_public_status'
    end
  end
  
  root 'users#index'
  get "up" => "rails/health#show", as: :rails_health_check
end
