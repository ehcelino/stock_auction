class AddWinnerIdToAuctionLots < ActiveRecord::Migration[7.0]
  def change
    add_column :auction_lots, :winner_id, :integer
  end
end
