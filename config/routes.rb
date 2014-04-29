Newvo::Application.routes.draw do
  root to: 'pages#home'

  #sessions
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy', as: 'signout'

  #web
  patch '/groups/add', to: 'groups#add_members'
  get '/posts/voted_on', to: 'posts#voted_on', as: 'posts_voted_on'
  get '/posts/not_voted_on', to: 'posts#not_voted_on'
  get '/posts/commented_on', to: 'posts#commented_on'
  patch '/users/describe', to: 'users#description'
  get '/pages/about', to: 'pages#about'
  get '/pages/legal', to: 'pages#legal'
  get '/pages/contact_us', to: 'pages#contact_us'

  resources :posts, only: [:index, :create, :show, :destroy] do
    resources :comments, only: [:create, :update, :destroy]
  end
  resources :activity_feed, only: :index
  resources :votes, only: :create
  resources :followings, only: [:create, :destroy, :show]
  resources :users, only: [:index, :show]
  resources :groups, only: [:create, :show, :destroy]

  namespace :api, :defaults => {:format => :json} do
   namespace :v1 do
    resources :users, only: [:index, :show]
    resources :activity_feed, only: :index
    resources :groups, only: [:create, :show, :destroy]
    get '/auth/mobile', to: 'sessions#create'
    get '/signout/mobile', to: 'sessions#destroy'
    patch '/groups/add', to: 'groups#add_members'
    get '/posts/voted_on', to: 'posts#voted_on', as: 'posts_voted_on'
    get '/posts/not_voted_on', to: 'posts#not_voted_on'
    get '/posts/commented_on', to: 'posts#commented_on'
    patch '/users/describe', to: 'users#description'
    get '/pages/about', to: 'pages#about'
    get '/pages/legal', to: 'pages#legal'
    get '/pages/contact_us', to: 'pages#contact_us'
    resources :posts, only: [:index, :create, :show, :destroy] do
      resources :comments, only: [:create, :update, :destroy]
    end
    resources :votes, only: :create
    resources :followings, only: [:create, :destroy]
    end
  end
end
