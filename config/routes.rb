# == Route Map
#
#                   Prefix Verb     URI Pattern                       Controller#Action
#                     root GET      /                                 home#index
#               home_index GET      /home/index(.:format)             home#index
#              sidekiq_web          /sidekiq                          Sidekiq::Web
#        new_admin_session GET      /admins/sign_in(.:format)         admins/sessions#new
#            admin_session POST     /admins/sign_in(.:format)         admins/sessions#create
#    destroy_admin_session DELETE   /admins/sign_out(.:format)        admins/sessions#destroy
#           admin_password POST     /admins/password(.:format)        admins/passwords#create
#       new_admin_password GET      /admins/password/new(.:format)    admins/passwords#new
#      edit_admin_password GET      /admins/password/edit(.:format)   admins/passwords#edit
#                          PATCH    /admins/password(.:format)        admins/passwords#update
#                          PUT      /admins/password(.:format)        admins/passwords#update
#         new_user_session GET      /users/sign_in(.:format)          users/sessions#new
#             user_session POST     /users/sign_in(.:format)          users/sessions#create
#     destroy_user_session DELETE   /users/sign_out(.:format)         users/sessions#destroy
#            user_password POST     /users/password(.:format)         users/passwords#create
#        new_user_password GET      /users/password/new(.:format)     users/passwords#new
#       edit_user_password GET      /users/password/edit(.:format)    users/passwords#edit
#                          PATCH    /users/password(.:format)         users/passwords#update
#                          PUT      /users/password(.:format)         users/passwords#update
# cancel_user_registration GET      /users/cancel(.:format)           users/registrations#cancel
#        user_registration POST     /users(.:format)                  users/registrations#create
#    new_user_registration GET      /users/sign_up(.:format)          users/registrations#new
#   edit_user_registration GET      /users/edit(.:format)             users/registrations#edit
#                          PATCH    /users(.:format)                  users/registrations#update
#                          PUT      /users(.:format)                  users/registrations#update
#                          DELETE   /users(.:format)                  users/registrations#destroy
#        user_confirmation POST     /users/confirmation(.:format)     devise/confirmations#create
#    new_user_confirmation GET      /users/confirmation/new(.:format) devise/confirmations#new
#                          GET      /users/confirmation(.:format)     devise/confirmations#show
#            list_articles GET|POST /articles/list(.:format)          articles#list
#                 articles GET      /articles(.:format)               articles#index
#                          POST     /articles(.:format)               articles#create
#              new_article GET      /articles/new(.:format)           articles#new
#             edit_article GET      /articles/:id/edit(.:format)      articles#edit
#                  article GET      /articles/:id(.:format)           articles#show
#                          PATCH    /articles/:id(.:format)           articles#update
#                          PUT      /articles/:id(.:format)           articles#update
#                          DELETE   /articles/:id(.:format)           articles#destroy
#

# bundle exec annotate --routes

Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  # sidekiq dashboard
  require 'sidekiq/web'
  authenticate :admin do
    mount Sidekiq::Web, at: "/sidekiq"
  end

  # Admin & User
  devise_for :admins, controllers: {
    sessions:       "admins/sessions",
    passwords:      "admins/passwords"
  }
  devise_for :users, controllers: {
    registrations:  "users/registrations",
    sessions:       "users/sessions",
    passwords:      "users/passwords"
  }

  # Article
  resources :articles do
    collection do
      match 'list', to: 'articles#list', via: [:get, :post]
    end
  end

end
