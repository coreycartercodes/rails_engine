# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show, :create, :update, :destroy]
      resources :merchants, only: [:index, :show, :create, :update, :destroy]
      resources :items do
        resources :merchants, only: :index
      end
      resources :merchants do
        resources :items, only: :index
      end
      namespace :merchants do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end
      namespace :items do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end
    end
  end



end
