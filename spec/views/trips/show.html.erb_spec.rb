# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'trips/show', type: :view do
  before(:each) do
    @trip = assign(:trip, Trip.create!(departure: 'Rouen', destination: 'Elboeuf'))
  end

  it 'renders current status <div>' do
    render

    assert_select 'div', text: @trip.status
  end
end
