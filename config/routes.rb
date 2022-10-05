Rails.application.routes.draw do
  namespace :api do
    resources :sessions
    resources :videos, shallow: true do
      resources :bookmarks, only: %i[create destroy]
      get :display_videos, on: :collection
    end
    resources :outputs, shallow: true do
      resources :likes, only: %i[create destroy]
    end
    resources :categories
    resources :comments
    resources :profile
    resources :videopreview
    resources :mypages do
      get :likes_comments_count, on: :collection
    end
    resources :bookmarks, only: %i[index] do
      get :bookmark_list, on: :collection
    end
    resources :users, only: %i[show create] do
      collection do
        get 'me'
      end
    end
    resources :password_resets, only: %i[create edit update]
  end

  root to: 'home#index'
  get '*path', to: 'home#index'
end
