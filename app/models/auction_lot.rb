class AuctionLot < ApplicationRecord

  validate :check_code
  validate :check_end_date
  validate :check_start_date
  validates :code, :start_date, :end_date, :min_bid_amount, :min_bid_difference, presence: true
  has_many :lot_items
  has_many :items, through: :lot_items

  enum status: { pending: 0, approved: 5, cancelled: 9 }

  private

  def check_code
    if self.code.present?
      unless self.code =~ /[a-zA-Z]{3}[0-9]{6}/
        self.errors.add(:code, 'inválido')
      end
    end
  end

  def check_end_date
    if start_date.present? && end_date.present?
      unless end_date > start_date
        self.errors.add(:end_date, 'deve ser maior que a data de início')
      end
    end
  end

  def check_start_date
    if start_date.present?
      unless start_date > Date.today
        self.errors.add(:start_date, 'deve ser futura')
      end
    end
  end

end
