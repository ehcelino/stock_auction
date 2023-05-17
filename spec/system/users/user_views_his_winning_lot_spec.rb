require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'Usuário vê lotes vencedores' do
  it 'com sucesso' do

    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                              role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                                role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    travel_to(2.months.ago) do
    @auction_lot = AuctionLot.create!(code:'XPG035410', start_date: 1.day.from_now, end_date: 45.days.from_now,
                                    min_bid_amount: 300, min_bid_difference: 50, status: 7, creator: first_admin, approver: second_admin)
    end
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @auction_lot.id, item_id: item.id)
    travel_to(30.days.ago) do
    bid = Bid.create!(auction_lot_id: @auction_lot.id, user_id: user.id, value: 301)
    end

    # Act
    login_as user
    visit root_path
    click_on 'Michael - michael@ig.com.br'

    # Assert
    expect(page).to have_content 'Usuário: Michael'
    expect(page).to have_content 'Leilões vencedores'
    expect(page).to have_content 'Lote: XPG035410'
    expect(page).to have_content 'Valor: R$ 301,00'

  end
end
