Rails.application.routes.draw do
  devise_for :profiles
  root to: "profile#index"
  # get 'profile', to
  resources :profile, only: %i[index]
  resources :analysis, only: %i[new create]
  resources :schedule, only: %i[new create]
  # get 'add_analysis', to: 'analysis#new'
  # post 'add_analysis', to: 'doc'

  get '/paginate_profiles', to: 'profile#paginate'
end
