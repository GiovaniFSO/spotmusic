Rails.application.routes.draw do
  get 'recently_heards/create'
  devise_for :users
  
  authenticated :user do
    root to: "dashboard#index", as: :authenticated_root
    resources :search, only: [:index, :new], as: :searches
    resources :categories, only: :show
    resources :artists, only: :show do
      post "/favorite", to: "favorites#create", on: :member, defaults: { format: :js, favoritable_type: 'Artist' }
      delete "/favorite", to: "favorites#destroy", on: :member, defaults: { format: :js, favoritable_type: 'Artist' }
    end
    resources :albums, only: :show do
      resources :recently_heards, only: :create
      post "/favorite", to: "favorites#create", on: :member, defaults: { format: :js, favoritable_type: 'Album' }
      delete "/favorite", to: "favorites#destroy", on: :member, defaults: { format: :js, favoritable_type: 'Album' }
    end
    resources :favorites, only: :index
    resources :songs, only: [] do
      post "/favorite", to: "favorites#create", on: :member, defaults: { format: :js, favoritable_type: 'Song' }
      delete "/favorite", to: "favorites#destroy", on: :member, defaults: { format: :js, favoritable_type: 'Song' }
    end
  end
 
  unauthenticated :user do
    root to: "home#index"
  end
end