# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TripsHelper, type: :helper do
  describe 'icon color' do
    it 'returns a color depending on the given status code' do
      expect(helper.icon_color('CREATED')).to eq('teal')
      expect(helper.icon_color('STARTED')).to eq('green')
      expect(helper.icon_color('CANCELLED')).to eq('grey')
    end
  end
end
