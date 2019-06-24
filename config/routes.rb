Rails.application.routes.draw do
  root to: 'summary#index'
  resources :transactions
  resources :accounts
  get '/summary', to: 'summary#index'

  namespace :api do
    namespace :v1 do
      resources :transactions
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
