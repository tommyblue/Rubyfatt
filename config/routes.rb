Rubyfatt::Application.routes.draw do
  # wiki_root '/wiki'
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :customers, except: [:new, :edit]
      resources :users, only: [] do
        collection do
          post :sign_in
        end
      end
    end
  end

  root 'dashboard#index'
end
