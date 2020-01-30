# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Trips', type: :feature do
  scenario 'User creates a new trip' do
    visit '/trips/new'

    fill_in 'Departure', with: 'Poitiers'
    fill_in 'Destination', with: 'Saint Benoit'

    click_button 'Créer ma Demande !'

    expect(page).to have_text('Trip was successfully created')
    expect(page).to have_text('CREATED')
  end

  scenario 'User starts a trip' do
    trip = Trip.create!(departure: 'Poitiers', destination: 'Saint Benoit')
    visit "/trips/#{trip.uid}"

    click_link'Je monte en voiture !'

    expect(page).to have_text('Trip was successfully started')
    expect(page).to have_text('STARTED')
  end

  scenario 'User cancels a trip' do
    trip = Trip.create!(departure: 'Poitiers', destination: 'Saint Benoit')
    visit "/trips/#{trip.uid}"

    click_link 'Annuler ma demande'

    expect(page).to have_text('Trip was successfully cancelled')
    expect(page).to have_text('CANCELLED')
  end
end
