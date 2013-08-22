BP::Application.routes.draw do

  resources :loas, except: :index


  resources :knowledges

  resources :courses

  resources :works

  resources :educations

  resources :schools

  resources :places

  resources :profiles, except: :index

  resources :addresses

  #resources :pdf

  get "home/index"
  devise_for :users
  
  get "about" => "home#about", as: "about"
  get "contact" => "home#contact", as: "contact"
  get "download" => "home#download", as: "download"
  #get "pfd" => "pfd#index", as: "pfd"

  get "pdf/download/:id" => "pdf#download", as: "pdf_download"
  get "pdf/save/:id" => "pdf#save", as: "pdf_save"

  
  get "pdf_cvs/download/:id" => "pdf_cvs#download", as: "pdf_cvs_download"
  get "pdf_cvs/save/:id" => "pdf_cvs#save", as: "pdf_cvs_save"

  get "pdf_als/download/:id" => "pdf_als#download", as: "pdf_als_download"
  get "pdf_als/save/:id" => "pdf_als#save", as: "pdf_als_save"


  scope "(:locale)", :locale => /en|de/ do
    root :to => 'home#index'
    get "home/index"
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
