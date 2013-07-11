Rubyfatt::Application.routes.draw do
  devise_for :users

  resources :customers, except: :show do
    resources :slips, except: :show do
      resources :time_entries, only: [ :new, :create, :destroy ]
    end
    resources :estimates, :invoices, :invoice_projects
  end

  # TODO: Migliorare queste risorse, non tutte le path generate vengono usate
  resources :recurring_slips do
    resources :recurring_invoice
  end

  match 'slips/working' => 'slips#working', as: :working_slips, via: :get

  match 'invoices/unpaid' => 'reports#unpaid_invoices', as: :unpaid_invoices, via: :get
  match 'invoice_projects' => 'invoice_projects#index', as: :invoice_projects, via: :get

  match 'invoice_projects/:id/from_recurring_slip' => 'invoice_projects#from_recurring_slip', via: :get, as: :new_recurring_slip_invoice_project
  match 'invoice_projects/:id/from_recurring_slip' => 'invoice_projects#create_from_recurring_slip', via: :post
  match 'invoice_projects/:invoice_project_id/to_invoice_form' => 'invoice_projects#to_invoice_form', as: :project_to_invoice_form, via: :get
  match 'invoice_projects/:invoice_project_id/to_invoice' => 'invoice_projects#to_invoice', as: :project_to_invoice, via: :post

  match 'profile' => 'profile#index', as: :profile, via: :get
  match 'profile/password/edit' => 'profile#password_edit', as: :edit_password, via: :get
  match 'profile/password/update' => 'profile#password_update', via: :patch
  match 'profile/edit' => 'profile#edit', as: :edit_profile, via: :get
  match 'profile/update' => 'profile#update', via: :patch
  match 'profile/destroy_logo' => 'profile#destroy_logo', via: :delete, as: 'destroy_logo'

  resources :options, only: [:index] do
    collection do
      put :save
    end
  end

  resources :work_categories, :except => [:show]

  resources :consolidated_taxes, :except => :show do
    resources :taxes, :except => [:index, :show]
  end

  resources :certifications, only: [:index, :edit, :update]

  match 'invoices/all' => 'invoices#all', as: :all_invoices, via: :get

  match 'invoice/:invoice_id/payment' => 'payments#create', via: :post
  match 'invoice/:invoice_id/payment' => 'payments#new', via: :get

  namespace :api do
    resources :customers, only: [:update]
  end

  root to: 'dashboard#index'
end
