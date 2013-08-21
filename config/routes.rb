BP::Application.routes.draw do

  get "pdf_als/index"
  get "pdf_cvs/index"
  resources :knowledges

  resources :courses

  resources :works

  resources :educations

  resources :schools

  resources :places

  resources :profiles, except: :index

  resources :addresses

  #resources :pdf

  root :to => "home#index"

  get "home/index"
  devise_for :users
  
  get "about" => "home#about", as: "about"
  get "contact" => "home#contact", as: "contact"
  #get "pfd" => "pfd#index", as: "pfd"
  get "pdf/:id" => "pdf#index", as: "pdf"
  get "pdf_cvs/:id" => "pdf_cvs#index", as: "pdf_cvs"
   get "pdf_als/:id" => "pdf_als#index", as: "pdf_als"
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
