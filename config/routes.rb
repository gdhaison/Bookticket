Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions: "manager/sessions"
  }, path: :manager

  devise_for :users, skip: :all
    as :user do
      get "/login", to: "users/sessions#new", :as => :new_user_session
      post "/login", to: "users/sessions#create", :as => :user_session
      delete "/logout", to: "users/sessions#destroy", :as => :destroy_user_session
      get "/register", to: "users/registrations#new", :as => :new_user_registration
      post "/register", to: "users/registrations#create", :as => :user_registration
  end

  root "static_pages#home"
  get "/schedule", to: "static_pages#schedule"
  get "/date", to: "static_pages#date"
  get "/show_city", to: "static_pages#show_city"
  get "/show_theater", to: "static_pages#show_theater"
  get "/show_showtime", to: "static_pages#show_showtime"
  get "/card/new" => "billings#new_card", as: :add_payment_method
  post "/card" => "billings#create_card", as: :create_payment_method
  get "/success" => "billings#success", as: :success
  post "/payment" => "billings#payment", as: :payment
  get "/reply_new", to: "comments#reply_new"

  get "/manager/movie_theaters/get_rooms", to: "manager/movie_theaters#get_rooms"
  namespace :manager do
    root "static_pages#index"
    resources :categories
    resources :users 
    resources :cities
    resources :movies
    resources :rooms
    resources :theaters
    resources :movie_theaters
    resources :reviews, only: [:index, :destroy]
    resources :orders
    resources :showtime_seats
    resources :scanners, only: [:new]
    resources :notifications
    mount ActionCable.server => '/cable'
    get 'notifications/:id/check', to: 'notifications#check_read',
                                      as: :check_read
  end  

  namespace :importfile do
    resources :imports
  end

  resources :movies, only: [:show, :index]
  resources :cities, only: [:index, :show]
  resources :users, only: [:show, :edit, :update]
  resources :theaters, only: [:show]
  resources :reviews
  resources :orders, only: [:new, :create, :show, :index]
  resources :movie_theaters, only: [:show]
  resources :reviews, only: [:create, :destroy]
  resources :billings, only: [:index]
  resources :test

  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"
  resources :comments
  resources :notifications
end
