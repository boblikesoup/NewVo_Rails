Newvo::Application.routes.draw do
  root to: 'pages#home'

  get '/auth/mobile/fbtoken=:facebook_token&device_id=:device_id&time_zone=:time_zone&os_type=:os_type', to: 'sessions#fb_sso'
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
    resources :posts, only: [:index, :create, :show, :destroy] do
      member do
        post 'search', path: 'posts/search'
     end
      resources :comments, only: [:create, :update, :edit, :destroy]
    end
    match 'posts/search' => 'posts#search', :via => :get
    resources :votes, only: :create
    resources :followings, only: [:create, :destroy, :show]
  end
end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
