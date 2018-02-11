Rails.application.routes.draw do

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  get '/signup', to: 'users#new'

  root 'static_pages#home'
  get '/about',  to: 'static_pages#about'

  resources :articles

  resources :articles do
    resources :comments,  only:[:create, :destroy]
  end

end
