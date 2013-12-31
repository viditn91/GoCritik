GoCritik::Application.routes.draw do
  
  devise_for :users
  namespace :admin do
    resources :fields
    resources :resources, path: ResourceName.pluralize.downcase
    get '/' => 'base#home'
  end
  resources :resources, only: [:index, :show], path: ResourceName.pluralize.downcase
  resources :reviews, only: :create 
  resources :comments, only: :create
  resources :likes, only: [:create, :destroy]
  resources :ratings, only: :create do
    put 'update', on: :collection 
  end
  root 'query#home'
end