# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      
      resources :revenue, only: :index
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/most_revenue', to: 'business#most_revenue'
        get '/:id/revenue', to: 'business#revenue'
        get '/most_items', to: 'business#most_items'
      end
      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :items, only: [:index, :show, :create, :update, :destroy]
      resources :merchants, only: [:index, :show, :create, :update, :destroy]
      resources :items do
        resources :merchants, only: :index
      end
      resources :merchants do
        resources :items, only: :index
      end
    end
  end



end
