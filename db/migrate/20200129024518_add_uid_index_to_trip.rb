class AddUidIndexToTrip < ActiveRecord::Migration[6.0]
  def change
    add_index :trips, :uid, unique: true
  end
end
