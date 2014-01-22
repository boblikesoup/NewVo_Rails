Newvo::Application.routes.draw do
  root to: 'pages#home'

  # For testing
  # get '/auth/mobile', to: 'sessions#fb_sso'

  # Real mobile auth route
  get '/auth/mobile', to: 'api/v1/sessions#create'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy', as: 'signout'

  resources :posts, only: [:index, :create, :show, :destroy] do
    resources :comments, only: [:create, :update, :edit, :destroy]
  end

  resources :votes, only: :create
  resources :followings, only: [:create, :destroy, :show]
  resources :users, only: [:index, :show]

  namespace :api, :defaults => {:format => :json} do
   namespace :v1 do
    resources :users, only: [:index, :show]
    get '/posts/search', to: 'posts#search'
    resources :posts, only: [:index, :create, :show, :destroy] do
     #  member do
     #    post 'search', path: 'posts/search'
     # end
      resources :comments, only: [:create, :update, :edit, :destroy]
    end
    # match 'posts/search' => 'posts#search', :via => :get
    resources :votes, only: :create
    resources :followings, only: [:create, :destroy, :show]
    end
  end
end
