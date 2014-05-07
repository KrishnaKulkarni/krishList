KrishList::Application.routes.draw do
  #root to: 'static_pages#root'
  root to: 'subcats#index'
  # get '/about', to: 'static_pages#about'
  # get '/safety', to: 'static_pages#safety'
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :destroy, :edit, :update] do
    get '/ads', to: 'users#posted_ads'
    get '/alerts', to: 'users#alerts'
    resources :notifications, only: [:index]
    resources :ads, only: [] do
      resources :responses, only: [:index]
    end
  end

  resources :subcats, only: [:index] do
    get '/options', to: 'subcats#options'
    resources :ads, only: [:show, :index, :new] do
      collection do
        post '/filter', to: 'ads#filter'
      end
    end
  end
  resources :ads, only:  [:new, :create, :destroy] do
    resources :responses, only: [:create]
  end

  get '/ads/:id/repost', to: 'ads#repost'
  post '/notifications/:id/viewed', to: 'notifications#viewed'


  resources :categories, only: [:show]
end
