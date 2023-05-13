class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :auction_lot
end
