  Rails.application.routes.draw do
  get "session/new"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace "api" do
    namespace "v1" do
      post 'upload', to: 'upload#upload_file'
      resources :posts
      resources :users do
        member do
          put 'update_user'
          put 'update_admin'
        end
        resources :notes
        resources :attendances, only: [:create, :index] do
          collection do
            get 'user_attendances'
            post 'create_to_recognize', to: 'attendances#create_to_recognize'
          end
        end
      end
      resources :departments, only: [:index]
      resources :attendance_types
      resources :salaries, only: [:index, :create] do
        collection do
          get 'total_work_hours_all_users'
        end
      end
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
