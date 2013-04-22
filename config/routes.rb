CUA::Application.routes.draw do
  resources :regimes


  resources :plates


  resources :ingredients


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end