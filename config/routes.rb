  Rails.application.routes.draw do
  get "session/new"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace "api" do
    namespace "v1" do
      resources :posts
      resources :users do
        resources :notes
        resources :attendances, only: [:create]
      end
      resources :attendances
      resources :attendance_types
      post "/login", to: "sessions#create"
      delete "/logout", to: "sessions#destroy"
      post '/calculate_salary', to: 'salary_calculator#calculate_salary'
      post 'generate_dataset/:user_id', to: 'face_recognition#generate_dataset'
      post 'train_classifier', to: 'face_recognition#train_classifier'
      post 'recognize', to: 'face_recognition#recognize'
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
