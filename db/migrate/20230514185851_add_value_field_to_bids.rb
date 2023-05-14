class AddValueFieldToBids < ActiveRecord::Migration[7.0]
  def change
    add_column :bids, :value, :decimal, precision: 10, scale: 2
  end
end
