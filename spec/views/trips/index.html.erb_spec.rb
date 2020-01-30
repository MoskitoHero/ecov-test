# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'trips/index', type: :view do
  before(:each) do
    assign(:trips, [
             Trip.create!,
             Trip.create!
           ])
  end

  it 'shows a welcome message' do
    render

    assert_select 'h1', text: 'Bienvenue sur Ecov !'
  end

  it 'shows a link to create a new trip' do
    render

    assert_select 'a[href=?]', new_trip_path
  end
end
