class Item < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  before_validation :generate_code, on: :create

  validates :name, :weight, :width, :height, :depth, presence: true

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end

end
