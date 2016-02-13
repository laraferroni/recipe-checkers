Rails.application.routes.draw do
  
  admin_only = ->(request) { request.env['warden'].authenticate? and request.env['warden'].user.admin? }
  constraints(->(request) { admin_only.(request) }) do
    get '/admin/tools' => "admin/tools#index"
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'


  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks",
    registrations: "registrations",
    confirmations: "confirmations",
    passwords: "passwords",
  } 
  delete "/users/auth/:provider" => "user_authentications#remove_auth", as: :user_omniauth_unauthorize

  root "home#index"
  get "users/dashboard" => "users#dashboard"
  get "users/whitelist" => "users#whitelist"
  get "users/blacklist" => "users#blacklist"
  
  resources :users

  get "recipe_revisions/promote" => "recipe_revisions#promote"
  get "recipes/preview" => "recipes#preview"
  get "recipes/apply" => "recipes#apply"
  get "recipes/approve" => "recipes#approve"
  get "recipes/approved" => "recipes#approved"
  get "recipes/unsubscribe" => "recipes#unsubscribe"
  
  resources :recipes

  get "recipe_ratings/helpfulness" => "recipe_ratings#helpfulness"
  resources :recipe_ratings
  resources :recipe_revisions

  get "recipe_notes/remove"=>"recipe_notes#remove"
  resources :recipe_notes
  resources :tester_recipes
  resources :projects
  resources :photos


  #emails
  get "projects/:id/tester_message" => "projects#tester_message"


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
