Newvo::Application.routes.draw do
  root to: 'pages#home'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/mobile', to: 'api/v1/sessions#create'
  get '/signout', to: 'sessions#destroy', as: 'signout'
  get '/signout/mobile', to: 'api/v1/sessions#destroy'

  resources :posts, only: [:index, :create, :show, :destroy] do
    resources :comments, only: [:create, :update, :edit, :destroy]
  end
  resources :activity_feed, only: :index
  resources :votes, only: :create
  resources :followings, only: [:create, :destroy, :show]
  resources :users, only: [:index, :show]

  namespace :api, :defaults => {:format => :json} do
   namespace :v1 do
    resources :users, only: [:index, :show]
    resources :activity_feed, only: :index
    resources :groups, only: [:create, :show]
    get '/posts/search', to: 'posts#search'
    post '/users/describe', to: 'users#description'
    resources :posts, only: [:index, :create, :show, :destroy] do
      resources :comments, only: [:create, :update, :edit, :destroy]
    end
    resources :votes, only: :create
    resources :followings, only: [:create, :destroy, :show]
    end
  end
end
