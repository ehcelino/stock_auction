require 'rails_helper'

describe 'Usuário vê lotes vencedores' do
  it 'com sucesso' do

    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                              role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                                role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    auction_lot = AuctionLot.new(code:'XPG035410', start_date: '20/04/2023', end_date: '01/05/2023',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 7, creator: first_admin, approver: second_admin)
    auction_lot.save!(validate: false)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)
    bid = Bid.new(auction_lot_id: auction_lot.id, user_id: user.id, value: 301)
    bid.save!(validate: false)

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
