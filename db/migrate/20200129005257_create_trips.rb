# frozen_string_literal: true

class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.string :uid, length: 4
      t.string :status

      t.timestamps
    end
  end
end
