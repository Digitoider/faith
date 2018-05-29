Rails.application.routes.draw do
  devise_for :profiles
  root to: "home#index"
end
