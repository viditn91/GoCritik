GoCritik::Application.routes.draw do
  
  namespace :admin do
    resources :fields
    resources :resources, path: ResourceName.pluralize.downcase
    get '/' => 'base#home'
  end

end