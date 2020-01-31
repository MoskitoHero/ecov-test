# frozen_string_literal: true

Rails.application.routes.draw do

  root to: redirect('/trips')
  resources 'trips', param: :uid, except: :update do
    member do
      put 'start', to: 'trips#start'
      put 'cancel', to: 'trips#cancel'
    end
  end
end
