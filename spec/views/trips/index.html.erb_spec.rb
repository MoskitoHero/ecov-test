# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'trips/index', type: :view do
  before(:each) do
    assign(:trips, [
             Trip.create!(departure: 'Rouen', destination: 'Elboeuf'),
             Trip.create!(departure: 'Labège', destination: 'Matabiau')
           ])
  end

  it 'shows a link to create a new trip' do
    render

    assert_select 'a[href=?]', new_trip_path
  end
end
