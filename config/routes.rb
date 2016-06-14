Rails.application.routes.draw do
  # Home
  root 'application#frontpage'
  get '/about'    => 'application#about'
  get '/contact'  => 'application#contact'
  get '/timeline' => 'application#timeline'

  # User
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Profile
  resources :profiles
  get '/profiles/:id/settings' => 'profiles#settings'

  # Musician Seeker
  get '/musician_seeker' => 'application#musician_seeker'
  get '/musicians_index' => 'application#musicians_index'

  # Jam Seeker
  get '/jam_seeker'   => 'application#jam_seeker'

  # Drum Circle Seeker
  get '/drum_circles' => 'application#drum_circles'

  # Remix Version Control
  get '/remixes'     => 'application#remixes'
end

=begin  
    
    new_user_session  GET     /users/sign_in   devise/sessions#new
        user_session  POST    /users/sign_in   devise/sessions#create
destroy_user_session  DELETE  /users/sign_out  devise/sessions#destroy

 new_user_password  GET    /users/password/new   devise/passwords#new
     user_password  POST   /users/password       devise/passwords#create
edit_user_password  GET    /users/password/edit  devise/passwords#edit
                    PATCH  /users/password       devise/passwords#update

cancel_user_registration  GET     /users/cancel   devise/registrations#cancel
   new_user_registration  GET     /users/sign_up  devise/registrations#new
       user_registration  POST    /users          devise/registrations#create
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