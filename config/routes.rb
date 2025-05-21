Rails.application.routes.draw do
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path
  root "home#index"

  
  if Rails.env.development?
    resources :mockups, only: [:show]
    resources :history_pages, only: [:show]
    resources :content_pages, only: [:create, :show]
  end
end