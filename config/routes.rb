# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: %i[create] do
    get ':username', action: :show, on: :collection
  end

  resources :sessions, only: %i[create destroy]
  resources :public_keys, only: %i[create index]
  resources :encrypted_private_keys, only: %i[create index]
end
