# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'trips/new', type: :view do
  before(:each) do
    assign(:trip, Trip.new)
  end

  it 'renders new trip form' do
    render

    assert_select 'form[action=?][method=?]', trips_path, 'post' do
      assert_select 'input[name=?]', 'trip[departure]'
      assert_select 'input[name=?]', 'trip[destination]'
    end
  end
end
