# == Route Map
#
#                Prefix Verb   URI Pattern                     Controller#Action
#                  root GET    /                               home#index
#            home_index GET    /home/index(.:format)           home#index
#     new_admin_session GET    /admins/sign_in(.:format)       admins/sessions#new
#         admin_session POST   /admins/sign_in(.:format)       admins/sessions#create
# destroy_admin_session DELETE /admins/sign_out(.:format)      admins/sessions#destroy
#        admin_password POST   /admins/password(.:format)      admins/passwords#create
#    new_admin_password GET    /admins/password/new(.:format)  admins/passwords#new
#   edit_admin_password GET    /admins/password/edit(.:format) admins/passwords#edit
#                       PATCH  /admins/password(.:format)      admins/passwords#update
#                       PUT    /admins/password(.:format)      admins/passwords#update
#

# bundle exec annotate --routes

Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  # Admin
  devise_for :admins, controllers: {
    sessions:       "admins/sessions",
    passwords:      "admins/passwords"
  }

end
