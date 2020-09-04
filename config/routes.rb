Rails.application.routes.draw do

  root 'tweets#index'
  devise_for :users
  resources :tweets
  resources :retweets
  resources :likes
  get 'tweets/show'

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
