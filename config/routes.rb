Rails.application.routes.draw do
  namespace :api do
    resources :sessions
    resources :videos
    resources :users, only: %i[create] do
      collection do
        get 'me'
      end
    end
  end

  root to: 'home#index'
  get '*path', to: 'home#index'
end
