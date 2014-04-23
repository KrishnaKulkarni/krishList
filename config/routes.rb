KrishList::Application.routes.draw do
  root to: 'static_pages#root'
  # get '/about', to: 'static_pages#about'
  # get '/safety', to: 'static_pages#safety'
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show] do
    get '/ads', to: 'users#posted_ads'
  end
  resources :subcats, only: [:index] do
    resources :ads, only: [:show, :index, :new]
  end
  resources :ads, only:  [:new, :create, :destroy]

end
