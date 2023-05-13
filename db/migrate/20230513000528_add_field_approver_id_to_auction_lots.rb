class AddFieldApproverIdToAuctionLots < ActiveRecord::Migration[7.0]
  def change
    add_column :auction_lots, :approver_id, :integer
  end
end
