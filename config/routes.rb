Rubyfatt::Application.routes.draw do
  devise_for :users

  resources :customers, :except => :show do
    resources :slips, :except => :show do
      resources :time_entries, :only => [ :new, :create, :destroy ]
    end
    resources :estimates, :invoices, :invoice_projects
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
  match 'invoice_projects/:invoice_project_id/to_invoice_form' => 'invoice_projects#to_invoice_form', :as => :project_to_invoice_form
  match 'invoice_projects/:invoice_project_id/to_invoice' => 'invoice_projects#to_invoice', :as => :project_to_invoice, :via => :post

  match 'profile' => 'profile#index', :as => :profile
  match 'profile/password/edit' => 'profile#password_edit', :as => :edit_password
  match 'profile/password/update' => 'profile#password_update', :via => :put
  match 'profile/edit' => 'profile#edit', :as => :edit_profile
  match 'profile/update' => 'profile#update', :via => :put

  resources :options, :only => [:index, :edit, :update]
  resources :work_categories, :except => [:show]

  resources :consolidated_taxes, :except => :show do
    resources :taxes, :except => [:index, :show]
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
