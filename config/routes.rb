Rails.application.routes.draw do
  root 'application#home'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :profiles
end

=begin      
    new_user_session  GET     /users/sign_in   devise/sessions#new
        user_session  POST    /users/sign_in   devise/sessions#create
destroy_user_session  DELETE  /users/sign_out  devise/sessions#destroy

     user_password  POST   /users/password       devise/passwords#create
 new_user_password  GET    /users/password/new   devise/passwords#new
edit_user_password  GET    /users/password/edit  devise/passwords#edit
                    PATCH  /users/password       devise/passwords#update

cancel_user_registration  GET     /users/cancel   devise/registrations#cancel
       user_registration  POST    /users          devise/registrations#create
   new_user_registration  GET     /users/sign_up  devise/registrations#new
  edit_user_registration  GET     /users/edit     devise/registrations#edit
                          PATCH   /users          devise/registrations#update
                          DELETE  /users          devise/registrations#destroy

     profiles  GET     /profiles           profiles#index
     profile   GET     /profiles/:id       profiles#show
               POST    /profiles           profiles#create
 new_profile   GET     /profiles/new       profiles#new
edit_profile   GET     /profiles/:id/edit  profiles#edit
               PATCH   /profiles/:id       profiles#update
               DELETE  /profiles/:id       profiles#destroy
=end