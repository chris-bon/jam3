Rails.application.routes.draw do
  devise_for :users
  root 'application#home'
  resources :profiles

  #     new_user_session GET    /users/sign_in  devise/sessions#new
  #         user_session POST   /users/sign_in  devise/sessions#create
  # destroy_user_session DELETE /users/sign_out devise/sessions#destroy

  #      user_password POST  /users/password      devise/passwords#create
  #  new_user_password GET   /users/password/new  devise/passwords#new
  # edit_user_password GET   /users/password/edit devise/passwords#edit
  #                    PATCH /users/password      devise/passwords#update

  # cancel_user_registration GET    /users/cancel  devise/registrations#cancel
  #        user_registration POST   /users         devise/registrations#create
  #    new_user_registration GET    /users/sign_up devise/registrations#new
  #   edit_user_registration GET    /users/edit    devise/registrations#edit
  #                          PATCH  /users         devise/registrations#update
  #                          DELETE /users         devise/registrations#destroy

  #     profiles GET    /profiles          profiles#index
  #      profile GET    /profiles/:id      profiles#show
  #              POST   /profiles          profiles#create
  #  new_profile GET    /profiles/new      profiles#new
  # edit_profile GET    /profiles/:id/edit profiles#edit
  #              PATCH  /profiles/:id      profiles#update
  #              DELETE /profiles/:id      profiles#destroy

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
