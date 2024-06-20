Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resource :search, only: [:show]

  namespace :playground do
    resource :summary, only: [:show]
    resource :related, only: [:show]

    root to: redirect("/playground/summary")
  end

  namespace :api do
    resources :autocompletes, only: %i[index]
  end

  root "hello#index"
end
