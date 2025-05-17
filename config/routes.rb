Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check 

  post "/analyse_page", to: "mockups#analyse_page"

  # ^^ health check endpoint at /up. Returns 200 if the application booted with no issues

  # root to: redirect('/mockups/list-pages')

  root "home#index"

  # Redirects the root URL (/) to /mockups/list-pages.

  resources :mockups if Rails.env.development?

end
