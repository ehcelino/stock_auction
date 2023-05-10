class AuctionLot < ApplicationRecord

  validate :check_code
  validate :check_end_date
  # Validação desabilitada para possibilitar a criação de lotes com data retroativa
  # validate :check_start_date
  validates :code, :start_date, :end_date, :min_bid_amount, :min_bid_difference, presence: true
  has_many :lot_items
  has_many :items, through: :lot_items
  has_many :bids
  has_many :users, through: :bids
  has_many :qnas

  enum status: { pending: 0, approved: 5, closed: 7, canceled: 9 }

  def biddable?
    self.status == 'approved' && self.end_date > Date.today && self.start_date < Date.today
  end

  def minimum_value
    if self.bids.none?
      self.min_bid_amount + 1
    else
      self.bids.last.value + self.min_bid_difference
    end
  end

  def release_items
    if self.items.count > 0
      self.lot_items.destroy_all
    end
  end

  def expired?
    self.end_date < Date.today
  end

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
