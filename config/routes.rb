KrishList::Application.routes.draw do
  root to: 'static_pages#root'
  # get '/about', to: 'static_pages#about'
  # get '/safety', to: 'static_pages#safety'
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :destroy, :edit, :update] do
    get '/ads', to: 'users#posted_ads'
    resources :notifications, only: [:index]
    resources :ads, only: [] do
      resources :responses, only: [:index]
    end
  end

  resources :subcats, only: [:index] do
    resources :ads, only: [:show, :index, :new]
  end
  resources :ads, only:  [:new, :create, :destroy] do
    resources :responses, only: [:create]
  end

  get '/ads/:id/repost', to: 'ads#repost'
  post '/notifications/:id/viewed', to: 'notifications#viewed'

end
