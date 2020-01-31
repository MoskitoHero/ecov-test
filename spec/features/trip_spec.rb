# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Trips', type: :feature do
  scenario 'User creates a new trip' do
    visit '/trips/new'

    fill_in 'trip_departure', with: 'Poitiers'
    fill_in 'trip_destination', with: 'Saint Benoit'

    click_button 'Créer ma Demande !'

    expect(page).to have_text('Trajet créé avec succès')
    expect(page).to have_text('CREATED')
  end

  scenario 'User starts a trip' do
    trip = Trip.create!(departure: 'Poitiers', destination: 'Saint Benoit')
    visit "/trips/#{trip.uid}"

    click_link 'start'

    expect(page).to have_text('Trajet créé avec succès')
    expect(page).to have_text('Poitiers')
    expect(page).to have_text('Saint Benoit')
    expect(page).to have_text('STARTED')
  end

  scenario 'User cancels a trip' do
    trip = Trip.create!(departure: 'Poitiers', destination: 'Saint Benoit')
    visit "/trips/#{trip.uid}"

    click_link 'cancel'

    expect(page).to have_text('Trajet annulé avec succès')
    expect(page).to have_text('Nouveau Trajet')
  end
end
