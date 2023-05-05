class LotItem < ApplicationRecord
  belongs_to :auction_lot
  belongs_to :item
end
