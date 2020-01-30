# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'trips/edit', type: :view do
  before(:each) do
    @trip = assign(:trip, Trip.create!)
  end

  it 'renders the edit trip form' do
    render

    assert_select 'form[action=?][method=?]', trip_path(@trip), 'post' do
      assert_select 'input[name=?]', 'trip[departure]'
      assert_select 'input[name=?]', 'trip[destination]'
    end
  end
end
