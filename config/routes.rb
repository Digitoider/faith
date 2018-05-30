Rails.application.routes.draw do
  devise_for :profiles
  root to: "profile#index"
  # get 'profile', to
  resources :profile, only: %i[index]
end
