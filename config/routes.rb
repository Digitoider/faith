Rails.application.routes.draw do
  devise_for :profiles
  root to: "profile#index"
  # get 'profile', to
  resources :profile, only: %i[index]
  resources :analysis, only: %i[new create]
  resources :schedule, only: %i[new create]
  post '/schedule/generate',     to: 'schedule#generate',      as: :schedule_generate
  get '/schedule/show',          to: 'schedule#show',          as: :schedule_show

  get '/paginate_profiles', to: 'profile#paginate'
end
