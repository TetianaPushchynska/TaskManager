Rails.application.routes.draw do
  devise_for :users, path: 'users', path_names: { sign_in: 'sign_in', sign_out: 'sign_out' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "tasks#index"

  resources :tasks do
    member do
      get :task_audits
    end
  end
end
