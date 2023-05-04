class CreateAuctionLots < ActiveRecord::Migration[7.0]
  def change
    create_table :auction_lots do |t|
      t.string :code
      t.date :start_date
      t.date :end_date
      t.integer :min_bid_amount
      t.integer :min_bid_difference
      t.integer :status, default: 0
      t.integer :created_by
      t.integer :approved_by

      t.timestamps
    end
  end
end
