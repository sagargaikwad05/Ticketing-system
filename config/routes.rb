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
  
     
      post '/signup', to: "users#create"
      post '/login', to: "users#login"
      
      post '/users', to: "users#create"
      get '/users', to: "users#index"
      get '/users/:id', to: "users#show"
      patch '/users/:id', to: "users#update"
      patch '/users', to: "users#update"
      delete '/users/:id', to: "users#destroy"

      post '/tickets', to: "tickets#create"
      get '/tickets', to: "tickets#index"
      get '/tickets/:id', to: "tickets#show"
      patch '/tickets/:id', to: "tickets#update"
      delete '/tickets/:id', to: "tickets#destroy"



        
      get '/open', to: "tickets#ticket_open"
      get '/awaiting_approval', to: "tickets#ticket_awaiting_approval"
      get '/ticket', to: "tickets#ticket_approved"
      get '/inprogress', to: "tickets#ticket_in_progress"
      get '/resolved', to: "tickets#ticket_resolved"
      get '/closed', to: "tickets#ticket_closed"
      post '/tickets', to: "tickets#create"
      
       

      # resources :users do
      #    resources :tickets

   

      

   
  end


