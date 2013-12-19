GoCritik::Application.routes.draw do
  
  devise_for :users
  namespace :admin do
    resources :fields
    resources :resources, path: ResourceName.pluralize.downcase
    get '/' => 'base#home'
  end
  root 'query#home'

end