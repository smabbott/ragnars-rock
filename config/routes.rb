Rails.application.routes.draw do
  resources :days

  root "home#index"
  resources :sounds

  resources :photos

  resources :locations

end
