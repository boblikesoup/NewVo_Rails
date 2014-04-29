Newvo::Application.routes.draw do
  root to: 'pages#home'

  #sessions
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/mobile', to: 'api/v1/sessions#create'
  get '/signout', to: 'sessions#destroy', as: 'signout'
  get '/signout/mobile', to: 'api/v1/sessions#destroy'

  #web
  patch '/groups/add', to: 'groups#add_members'
  get '/posts/search', to: 'posts#search'
  get '/posts/voted_on', to: 'posts#voted_on', as: 'posts_voted_on'
  get '/posts/not_voted_on', to: 'posts#not_voted_on'
  get '/posts/commented_on', to: 'posts#commented_on'
  patch '/users/describe', to: 'users#description'
  get '/pages/about', to: 'pages#about'
  get '/pages/legal', to: 'pages#legal'
  get '/pages/contact_us', to: 'pages#contact_us'

  resources :posts, only: [:index, :create, :show, :destroy] do
    resources :comments, only: [:create, :update, :edit, :destroy]
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
    resources :posts, only: [:index, :create, :show, :destroy] do
    resources :comments, only: [:create, :update, :destroy]
    end
    #api
    patch '/groups/add', to: 'groups#add_members'
    get '/posts/search', to: 'posts#search'
    get '/posts/voted_on', to: 'posts#voted_on', as: 'posts_voted_on'
    get '/posts/not_voted_on', to: 'posts#not_voted_on'
    get '/posts/commented_on', to: 'posts#commented_on'
    patch '/users/describe', to: 'users#description'
    get '/pages/about', to: 'pages#about'
    get '/pages/legal', to: 'pages#legal'
    get '/pages/contact_us', to: 'pages#contact_us'
    resources :votes, only: :create
    resources :followings, only: [:create, :destroy]
    end
  end
end
