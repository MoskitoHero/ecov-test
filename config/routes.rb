# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'trips/:id', to: 'trips#show'
  # post 'trips/create'
  # put 'trips/:id', to: 'trips#update'
  # delete 'trips/:id', to: 'trips#destroy'

  resources 'trips', param: :uid, except: :update do
    member do
      put 'start', to: 'trips#start'
      put 'cancel', to: 'trips#cancel'
    end
  end
end
