# == Route Map
#
#     Prefix Verb URI Pattern           Controller#Action
#       root GET  /                     home#index
# home_index GET  /home/index(.:format) home#index
#

# bundle exec annotate --routes

Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

end
