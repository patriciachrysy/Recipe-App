Rails.application.routes.draw do
  devise_for :users

  resources :foods, except: %i[show]

  root 'users#index'
  get "up" => "rails/health#show", as: :rails_health_check
end
