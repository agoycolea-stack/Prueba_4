Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :tweets
  resources :retweets
  resources :likes
  get 'tweets/show'
  root 'tweets#index'
  get 'apis/:news', to: 'api#news'
  get 'api/:from/:to', to: 'api#dates'
  get 'api/dates'
  post 'api/tweets', to: "tweets#create"

  namespace :api, defaults: {format: :json} do
    namespace :v1 do 
      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
      end
    end
  end
  
end
