GoCritik::Application.routes.draw do

  devise_for :users
  namespace :admin do
    resources :fields
    resources :resources, path: ResourceName.pluralize.downcase do
      put 'approve', on: :member
    end
    resources :templates, only: [:edit, :update, :index, :show]
    get '/' => 'base#home'
  end
  resources :resources, only: [:new, :create, :index, :show], path: ResourceName.pluralize.downcase
  resources :reviews, only: [:create, :show, :destroy] 
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :ratings, only: :create do
    put 'update', on: :collection 
  end
  resources :users, only: [:show, :edit, :update]
  resources :pictures, only: [:create, :show, :update, :destroy]
  # root 'resources#index'
  root 'query#home'

end