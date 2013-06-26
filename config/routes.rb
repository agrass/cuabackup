CUA::Application.routes.draw do
  resources :areas


  resources :reports


  resources :orders


  resources :patients do
    collection { post :import }
  end


  resources :regimes
  match 'regime/stats', :to => 'regimes#stats', :as => :regime_stats


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