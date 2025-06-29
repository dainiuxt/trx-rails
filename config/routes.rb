Rails.application.routes.draw do
  get "/register", to: "users#new"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "workouts#index"

  get "/workouts", to: "workouts#index"
  resources :workouts do
    resources :exercises
  end

  resources :exercises do
    resources :workouts
  end

  resource :session
  resources :passwords, param: :token

  resources :users, only: %i[ new create index destroy edit ]
  resources :users do
    member do
      patch :approve
      patch :suspend
    end
  end
end
