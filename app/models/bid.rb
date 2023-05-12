class Bid < ApplicationRecord
  belongs_to :auction_lot
  belongs_to :user
  validates :value, presence: true
  before_validation :check_value
  before_validation :check_date
  before_validation :check_user

  def check_value
    auction_lot = AuctionLot.find(self.auction_lot_id)
    unless self.value.nil?
      if (auction_lot.bids.none? && self.value < auction_lot.min_bid_amount + 1) || (!auction_lot.bids.none? && self.value < auction_lot.bids.last.value + auction_lot.min_bid_difference)
        return self.errors.add(:value, 'menor que o valor mínimo para este lance')
      end
    end
  end

  def check_date
    if self.auction_lot.end_date < Date.today
      self.errors.add(:base, "Este leilão não pode receber novos lances")
    end
  end

  def check_user
    if self.user.present? && self.user.role == "admin"
      self.errors.add(:base, 'Usuários administradores não podem fazer lances')
    end
  end

end
