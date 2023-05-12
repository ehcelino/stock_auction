require 'rails_helper'

RSpec.describe Bid, type: :model do
  it 'Usuário tenta registrar um lance em um leilão que já venceu' do
    # Arrange
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/03/2023', end_date: '10/04/2023',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 5, created_by: 1, approved_by: 2)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')

    # Act
    bid = Bid.new(auction_lot: auction_lot, user: user, value: 320)
    bid.valid?
    result = bid.errors.full_messages

    # Assert
    expect(result[0]).to eq 'Este leilão não pode receber novos lances'
  end
end
