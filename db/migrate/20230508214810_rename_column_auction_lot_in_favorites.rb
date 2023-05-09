class RenameColumnAuctionLotInFavorites < ActiveRecord::Migration[7.0]
  def self.up
    rename_column :favorites, :auction_lot, :auction_lot_id
  end
  def self.down
  end
end
