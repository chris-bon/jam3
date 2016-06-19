Rails.application.routes.draw do
  root 'pages#homepage'
  
  get  '/about'    => 'pages#about',    as: 'about'
  get  '/contact'  => 'pages#contact',  as: 'contact'
  get  '/timeline' => 'pages#timeline', as: 'timeline'
  post '/email'    => 'pages#email',    as: 'email'

  # Devise Users
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  # Profiles
  get    '/profiles'          => 'profiles#index',  as: 'profiles'
  get    '/profiles/:id'      => 'profiles#show',   as: 'profile'
  # Create
  get    '/profiles/new'      => 'profiles#new',    as: 'new_profile'
  post   '/profiles'          => 'profiles#create'
  # Edit
  get    '/profiles/:id/edit' => 'profiles#edit',   as: 'edit_profile'
  patch  '/profiles/:id'      => 'profiles#update'
  # Delete
  delete '/profiles/:id'      => 'profiles#destroy'

  # Apps
  get '/musician_seeker' => 'application#musician_seeker'
  get '/musicians_index' => 'application#musicians_index'
  get '/drum_circles'    => 'application#drum_circles'
  mount Thredded::Engine => '/forum'

  resources :posts
end