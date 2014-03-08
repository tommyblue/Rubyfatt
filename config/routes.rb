Rubyfatt::Application.routes.draw do
  # wiki_root '/wiki'
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :customers, only: [:index]
    end
  end

  root 'dashboard#index'
end
