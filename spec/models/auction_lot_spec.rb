require 'rails_helper'

RSpec.describe AuctionLot, type: :model do

  describe '#valid?' do
    it 'deve ter um código válido' do
      # Arrange
      auction_lot = AuctionLot.new(code:'035410XPG', start_date: '01/05/2023', end_date: '10/06/2023',
                                  min_bid_amount: 300, min_bid_difference: 50, status: 5, created_by: 1, approved_by: 2)

      # Act
      result = auction_lot.valid?

      #Assert
      expect(result).to be false
    end

    it 'deve ter uma data final válida' do
      # Arrange
      auction_lot = AuctionLot.new(code:'XPG035410', start_date: '01/05/2023', end_date: '10/04/2023',
                                  min_bid_amount: 300, min_bid_difference: 50, status: 5, created_by: 1, approved_by: 2)

      # Act
      result = auction_lot.valid?

      #Assert
      expect(result).to be false
    end

    it 'deve ser aprovado por um usuário diferente' do
      # Arrange
      auction_lot = AuctionLot.new(code:'XPG035410', start_date: '01/05/2023', end_date: '10/06/2023',
                                  min_bid_amount: 300, min_bid_difference: 50, status: 5, created_by: 1, approved_by: 1)

      # Act
      result = auction_lot.valid?

      #Assert
      expect(result).to be false
      expect(auction_lot.errors.full_messages[0]).to eq 'Um lote não pode ser aprovado pelo usuário que o criou'

    end
  end

end
