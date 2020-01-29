class AddPaymentDataToTrip < ActiveRecord::Migration[6.0]
  def change
    add_column :trips, :payment_data, :jsonb
  end
end
