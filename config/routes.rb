Rubyfatt::Application.routes.draw do
  devise_for :users

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
  resources :customers do
    resources :slips, :estimates, :invoices, :invoice_projects
  end
  
  # TODO: Migliorare queste risorse, non tutte le path generate vengono usate
  resources :recurring_slips do
    resources :recurring_invoice
  end
  
  match 'slips/working' => 'slips#working', :as => :working_slips
  
  match 'invoices/unpaid' => 'reports#unpaid_invoices', :as => :unpaid_invoices
  match 'invoice_projects' => 'invoice_projects#index', :as => :invoice_projects
  
  match 'invoice_projects/:id/from_recurring_slip' => 'invoice_projects#from_recurring_slip', :via => :get, :as => :new_recurring_slip_invoice_project
  match 'invoice_projects/:id/from_recurring_slip' => 'invoice_projects#create_from_recurring_slip', :via => :post
  match 'invoice_projects/:id/to_invoice' => 'invoice_projects#to_invoice', :as => :project_to_invoice
  
  match 'profile' => 'profile#index', :as => :profile
  match 'profile/password/edit' => 'profile#password_edit', :as => :edit_password
  match 'profile/password/update' => 'profile#password_update', :via => :put
  match 'profile/edit' => 'profile#edit', :as => :edit_profile
  match 'profile/update' => 'profile#update', :via => :put
  
  resources :options
  
  resources :consolidated_taxes do
    resources :taxes
  end
  
  match 'invoices/all' => 'invoices#all', :as => :all_invoices
  
  match 'invoice/:invoice_id/payment' => 'payments#create', :via => :post
  match 'invoice/:invoice_id/payment' => 'payments#new', :via => :get
  
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
  root :to => 'dashboard#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
