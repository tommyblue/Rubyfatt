Rubyfatt::Application.routes.draw do
  # wiki_root '/wiki'
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :customers, except: [:new, :edit]
      resources :invoices, only: [:index] do
        collection do
          get 'year/:year', to: 'invoices#index', year: /\d{4}/
        end
      end
      resources :users, only: [] do
        collection do
          get :profile
          post :sign_in
        end
      end
    end
  end

  root 'dashboard#index'
end
