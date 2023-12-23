Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end

  resources :foods, except: %i[show]
  
  resources :users, only: %i[index show]

  resources :recipes, only: %i[index show new create destroy] do
    member do
      get 'update_public_status'
    end
    resources :recipe_foods, except: %i[index show]
  end

  get "/public_recipes" => "recipes#public_recipes"

  get "/general_shopping_list" => "recipe_foods#generate_shopping_list"
  
  root 'recipes#public_recipes'
  
  get "up" => "rails/health#show", as: :rails_health_check
end
