# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Trip, type: :model do
  before :each do
    @trip = Trip.create
  end

  it 'status is set to "CREATED" on creation' do
    expect(@trip.status).to eq('CREATED')
  end

  it 'status can be updated' do
    @trip.update(status: 'STARTED')
    expect(@trip.status).to eq('STARTED')
  end

  it 'generates a unique code of 4 characters on creation' do
    @second_trip = Trip.create
    expect(@trip.uid).not_to be_falsey
    expect(@trip.uid.size).to eq(4)
    expect(@trip.uid).to match(/[0-9a-zA-Z]{4}/)
    expect(@second_trip.uid).not_to eq(@trip.uid)
  end

  it 'logs its status changes in the console' do
    expect(Rails.logger).to receive(:info).with("STATUS CHANGE: Trip #{@trip.uid} is now STARTED")
    @trip.update!(status: 'STARTED')
  end

  it 'creates a bill on creation' do
    # NOTE: Pas convaincu par cette implémentation. Cf. app/models/trip.rb
    # Ici, je suis dans les specs du modèle Trip et je check le paiement.
    # Ca ressemble plus à un spec d'intégration/système
    expect(@trip.payment_data['status']).to eq('billed')
  end

  it 'pays the bill when it starts' do
    # NOTE: IDEM.
    @trip.update(status: 'STARTED')
    expect(@trip.payment_data['status']).to eq('paid')
  end

  it 'reimburses the bill when it is cancelled' do
    # NOTE: IDEM.
    @trip.update(status: 'CANCELLED')
    expect(@trip.payment_data['status']).to eq('reimbursed')
  end
end
