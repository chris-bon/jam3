# frozen_string_literal: true
Rails.application.routes.draw do
  root to: 'application#index'

  resources :user_sessions,
            only: [:new, :create],
            controller: 'sessions'
  delete '/session' => 'sessions#destroy',
         as: :destroy_user_session

  resources :users, only: [:show], path: 'u'

  mount RailsEmailPreview::Engine, at: '/emails'
  mount Thredded::Engine => '/thredded'
end
