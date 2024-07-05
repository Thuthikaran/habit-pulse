Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :habits, only: %i[index new create edit update destroy] do
    collection do
      get :filter_by_date
    end
  end
  resources :habit_statics, only: %i[show]

  get 'contact', to: 'pages#contact'
  get 'about', to: 'pages#about'
  get 'habits/:id/complete', to: 'habits#complete', as: 'complete_habit'

  post 'guest_login', to: 'sessions#guest_login'
  #get 'create', to:'habits#new'

  get 'habits/today', to: 'habits#today'


end
