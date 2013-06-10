CUA::Application.routes.draw do
  resources :reports


  resources :orders


  resources :patients


  resources :regimes


  resources :plates


  resources :ingredients


  resources :order_lists


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users


  match 'get_plates', :to => 'regimes#get_plates', :as => :regime_plates
  match 'cuapanel', :to => 'home#cuaPanel'
  match 'admin', :to => 'home#admin'
  match 'get_form_select_plates', :to => 'regimes#get_form_select', :as => :regime_plates
end