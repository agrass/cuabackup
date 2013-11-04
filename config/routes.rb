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
  get 'pdf_show', :to => 'reports#pdf_show', :as => :pdf_show
  get 'pdf_list', :to => 'reports#pdf_list'
  match 'get_plates', :to => 'regimes#get_plates', :as => :regime_plates
  match 'cuapanel', :to => 'home#cuaPanel'
  match 'admin', :to => 'home#admin'
  match 'reporte_areas', :to => 'home#area', :as => "reporte_areas"
  match 'get_form_select_plates', :to => 'regimes#get_form_select', :as => :regime_plates
  match 'upDay', :to => 'home#upDay', :as => :upDay
  match 'downDay', :to => 'home#downDay', :as => :downDay
  match 'notifications', :to => 'notifications#notifications', :as => :notifications

end