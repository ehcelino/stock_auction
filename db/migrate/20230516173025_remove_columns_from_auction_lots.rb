class RemoveColumnsFromAuctionLots < ActiveRecord::Migration[7.0]
  def change
    remove_column :auction_lots, :created_by, :integer
    remove_column :auction_lots, :approved_by, :integer
  end
end
