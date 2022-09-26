Rails.application.routes.draw do
  namespace :api do
    resources :sessions
    resources :videos, shallow: true do
      resources :bookmarks, only: %i[create destroy]
    end
    resources :outputs, shallow: true do
      resources :likes, only: %i[create destroy]
    end
    resources :categories
    resources :comments
    resources :bookmarks, only: %i[index] do
      get :bookmark_list, on: :collection
    end
    resources :users, only: %i[create] do
      collection do
        get 'me'
      end
    end
  end

  root to: 'home#index'
  get '*path', to: 'home#index'
end
