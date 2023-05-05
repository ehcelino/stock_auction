class Item < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  before_validation :generate_code, on: :create
  has_many :lot_items
  has_many :auction_lots, through: :lot_items
  validates :name, :weight, :width, :height, :depth, presence: true

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end

end
