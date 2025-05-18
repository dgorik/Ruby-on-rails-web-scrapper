Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check 
  # ^^ health check endpoint at /up. Returns 200 if the application booted with no issues

  # get 'show-page', to: 'mockups#show' 

  # When a user makes a GET request to /show-page, run the show action in the MockupsController.

  post "create", to: "content_pages#create"

  # root to: redirect('/mockups/list-pages')

  root "home#index"

  # Redirects the root URL (/) to /mockups/list-pages.

  resources :mockups if Rails.env.development?

  resources :content_pages if Rails.env.development?

end
