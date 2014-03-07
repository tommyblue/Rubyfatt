Rubyfatt::Application.routes.draw do
  # wiki_root '/wiki'
  devise_for :users

  root 'dashboard#index'
end
