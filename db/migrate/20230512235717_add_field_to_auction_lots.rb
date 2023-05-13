class AddFieldToAuctionLots < ActiveRecord::Migration[7.0]
  def change
    add_column :auction_lots, :creator_id, :integer
  end
end
