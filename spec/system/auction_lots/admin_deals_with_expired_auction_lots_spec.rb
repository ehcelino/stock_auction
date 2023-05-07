require 'rails_helper'

describe 'Admin vê os lotes expirados' do
  it 'e cancela um lote que não teve lances' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                              role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                                role: 1, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/04/2023', end_date: '01/05/2023',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 5, created_by: first_admin.id, approved_by: second_admin.id)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)

    # Act
    login_as first_admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Lotes expirados'
    click_on 'XPG035410'
    click_on 'Cancelar o lote'

    # Assert
    expect(page).to have_content 'Lote cancelado'
  end

  it 'e finaliza um lote que teve lances' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                              role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                                role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/04/2023', end_date: '01/05/2023',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 5, created_by: first_admin.id, approved_by: second_admin.id)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)
    Bid.create!(auction_lot_id: auction_lot.id, user_id: user.id, value: 301)

    # Act
    login_as first_admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Lotes expirados'
    click_on 'XPG035410'
    click_on 'Finalizar o lote'

    # Assert
    expect(page).to have_content 'Lote finalizado com sucesso'
    expect(page).to have_content 'Status: Finalizado'
  end

end
