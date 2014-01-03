# -*- encoding : utf-8 -*-
TestApp::Application.routes.draw do

  #get "payments/new"

  devise_for :users
  get "summury/totals"
  get "static_pages/faq"
  get "static_pages/about"
  get "static_pages/contacts"
  get "help", to: "static_pages#help"
  root to: 'StaticPages#about'
  resources :lotts do
    get :status, on: :member
  end
  resources :products
  resources :summury do
      get :totals, on: :member
      get :dolzhnik_notify, on: :member
  end 
  resources :users
  resources :orders do
    get :pay_for, on: :member
  end 
  resources :items
  resources :payments do
    get :status, on: :member
    get :status_problem, on: :member
#    get :ordernacc, on: :collection
#    get :orderacc, on: :collection
  end 
  resources :purchases
  resources :admin_items do
    get :status, on: :member
    get :payd, on: :member
    get :cancel, on: :member
    get :pay_for_override, on: :member
    get :na_sklade, on: :member
    get :list_pay, on: :collection  
    get :list_confirm, on: :collection
    get :list_payments, on: :collection
    get :list_lotts, on: :collection
    get :list_lotts_all, on: :collection
    get :list_items, on: :collection
    get :re_check, on: :member
  end
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
