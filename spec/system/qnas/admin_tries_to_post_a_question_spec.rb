require 'rails_helper'

describe 'Administrador tenta postar uma pergunta' do
  it 'e não consegue' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
          role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
            role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
    role: 0, password: 'password')
    travel_to(1.month.ago) do
    @auction_lot = AuctionLot.create!(code:'XPG035410', start_date: 1.day.from_now, end_date: 2.months.from_now,
                min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: first_admin, approver: second_admin)
    end
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
    width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @auction_lot.id, item_id: item.id)
    Bid.create!(auction_lot_id: @auction_lot.id, user_id: user.id, value: 301)

    # Act
    login_as first_admin
    visit root_path
    click_on 'Lote XPG035410'
    click_on 'Fazer uma pergunta'

    # Assert
    expect(current_path).to eq "#{auction_lots_path}/#{@auction_lot.id}"
    expect(page).to have_content 'Esta função não é permitida para administradores'
  end
end
