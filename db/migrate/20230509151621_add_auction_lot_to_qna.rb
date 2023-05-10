class AddAuctionLotToQna < ActiveRecord::Migration[7.0]
  def change
    add_reference :qnas, :auction_lot, null: false, foreign_key: true
  end
end
