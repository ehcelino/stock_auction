class AuctionLot < ApplicationRecord

  validate :check_code
  validates :code, :start_date, :end_date, :min_bid_amount, :min_bid_difference, presence: true

  private

  def check_code
    if self.code.present?
      unless self.code =~ /[a-zA-Z]{3}[1-9]{6}/
        self.errors.add(:code, 'inválido')
      end
    end
  end

end
