class AuctionLot < ApplicationRecord

  validate :check_code
  validate :check_end_date
  # Validação desabilitada para possibilitar a criação de lotes com data retroativa
  # validate :check_start_date
  validates :code, :start_date, :end_date, :min_bid_amount, :min_bid_difference, presence: true
  validates :code, uniqueness: true
  validates :min_bid_amount, :min_bid_difference, numericality: { greater_than: 1 }
  before_validation :check_user
  has_many :lot_items
  has_many :items, through: :lot_items
  has_many :bids
  has_many :users, through: :bids
  has_many :qnas
  belongs_to :creator, class_name: "User"
  belongs_to :approver, class_name: "User", optional: true

  enum status: { pending: 0, approved: 5, closed: 7, canceled: 9 }

  scope :current,  -> { where('start_date <= ? AND end_date >= ?', Date.today, Date.today) }
  scope :future,  -> { where('start_date > ?', Date.today) }
  scope :expired, -> { where('end_date < ?', Date.today) }

  def biddable?
    self.status == 'approved' && self.end_date > Date.today && self.start_date < Date.today
  end

  def questionable?
    self.status == 'approved' && self.end_date > Date.today
  end

  def favoritable?
    self.status != "closed" && self.status != "pending" && self.end_date > Date.today
  end

  def editable?
    (self.status == "pending" || self.status == "approved") && self.end_date > Date.today
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

  def check_user
    if self.creator == self.approver
      self.errors.add(:base, 'Um lote não pode ser aprovado pelo usuário que o criou')
    end
  end

  def check_code
    if self.code.present?
      unless self.code =~ /[a-zA-Z]{3}[0-9]{6}/
        self.errors.add(:code, 'inválido. O formato é XXX000000')
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
