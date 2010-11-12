ActionController::Routing::Routes.draw do |map|
  map.resources :operations

  map.resources :messages
  map.resources :antorchas
  map.root :controller => 'home', :action => 'index'
end
