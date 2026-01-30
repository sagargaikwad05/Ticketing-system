# config/routes.rb
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # The explicit 'post' route is redundant if using resources, but here is a corrected version:
  # post 'tickets', to: 'tickets#create' 

  # Use resources for standard RESTful routes, including POST /tickets
  # resources :tickets, only: [:create] # You might need other actions like :index, :show, etc.

  # Nested routes remain as you defined them
  

  resources :users do
    resources :tickets

    # resources :tickets, only: [:index]
   
  end
end
