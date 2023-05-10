class Qna < ApplicationRecord
  belongs_to :auction_lot

  enum status: { approved: 0, hidden: 5 }
end
