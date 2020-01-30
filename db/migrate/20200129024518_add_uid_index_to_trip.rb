class AddUidIndexToTrip < ActiveRecord::Migration[6.0]
  def change
    change_column :trips, :uid, :string, limit: 4, null: false
    add_index :trips, :uid, unique: true
  end
end
