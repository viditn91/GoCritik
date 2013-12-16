GoCritik::Application.routes.draw do
  
  namespace :admin do
    resources :fields, :fields_values, :resources
  end
  
end