class Qna < ApplicationRecord
  belongs_to :auction_lot
  has_one :user
  validates :question, presence: true
  enum status: { approved: 0, hidden: 5 }
end
