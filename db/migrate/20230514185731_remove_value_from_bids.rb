class RemoveValueFromBids < ActiveRecord::Migration[7.0]
  def change
    remove_column :bids, :value, :integer
  end
end
