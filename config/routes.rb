Rails.application.routes.draw do

  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    mount RailsAdmin::Engine => "/admin", as: "rails_admin"
    devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions"}
    resources :users, only: :show
    resources :products, only: :show
    resources :reviews, only: %i(new create)
    resources :carts, only: %i(index create update destroy)
    resources :orders, only: %i(create index update)
    resources :categories, only: :show
    get "/search", to: "search_products#search"
    get "/newproduct", to: "newproducts#index"
    get "/topsale", to: "topsales#index"
  end
end
