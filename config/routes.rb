GoCritik::Application.routes.draw do
  
  namespace :admin do
    resources :fields, :fields_values
    resources :resources, path: ResourceName.pluralize.downcase
  end
  
end