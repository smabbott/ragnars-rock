Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks'}
  resources :days

  root "home#index"
  resources :sounds

  resources :photos do
    collection do
      post :sort
    end
  end

  resources :locations

end
