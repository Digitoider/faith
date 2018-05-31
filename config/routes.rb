Rails.application.routes.draw do
  devise_for :profiles
  root to: "profile#index"
  # get 'profile', to
  resources :profile, only: %i[index]
  get 'add_analysis', to: 'doctor#add_analysis'

  get '/paginate_profiles', to: 'profile#paginate'
end
