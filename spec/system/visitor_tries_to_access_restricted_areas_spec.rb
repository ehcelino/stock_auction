require 'rails_helper'

describe 'Visitante acessa o site' do
  it 'e tenta postar um lance sem estar logado' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
          role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
            role: 1, password: 'password')
    travel_to(1.month.ago) do
    @auction_lot = AuctionLot.create!(code:'XPG035410', start_date: 1.day.from_now, end_date: 2.months.from_now,
                min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: first_admin, approver: second_admin)
    end
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
    width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @auction_lot.id, item_id: item.id)

    # Act
    get(new_auction_lot_bid_path(@auction_lot))

    # Assert
    expect(response).to redirect_to(root_path)
  end
end
