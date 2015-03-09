Rails.application.routes.draw do
  devise_for :users 
 root to: "home#index"

 scope '/dashboard' do
  get "/" => 'dashboard#show', as: 'dashboard'
  get '/bikes' => 'bikes#index', as: 'bikes'
  get '/buses' => 'buses#index', as: 'buses'
  get '/rails' => 'rails#index', as: 'rails'
  resources :station, only: [:create, :new, :destroy] 
 end

patch '/users/:id' => 'users#update', as: 'edit_user_location'

end
