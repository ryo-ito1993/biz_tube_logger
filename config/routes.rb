Rails.application.routes.draw do
  namespace :api do
    resources :sessions, only: %i[create] do
      post :guest_login, on: :collection
    end
    resources :videos, shallow: true do
      resources :bookmarks, only: %i[create destroy]
      get :display_videos, on: :collection
    end
    resources :outputs, shallow: true do
      resources :likes, only: %i[create destroy]
    end
    resources :categories, only: %i[index]
    resources :comments, only: %i[create update destroy]
    resources :profile, only: %i[update]
    resources :videopreview, only: %i[create]
    resources :mypages, only: %i[index]
    resources :bookmarks, only: %i[index] do
      get :bookmark_list, on: :collection
    end
    resources :users, only: %i[create] do
      collection do
        get 'me'
      end
    end
    resources :password_resets, only: %i[create update]
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root to: 'home#index'
  get '*path', to: 'home#index'
end
