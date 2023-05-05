require 'rails_helper'

describe 'Usuário vê detalhes de um lote' do

  it 'como usuário cadastrado' do

    # Arrange
    User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                role: 1, password: 'password')
    User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                role: 1, password: 'password')
    user = User.create!(name: 'Fernando', cpf: 88262301021, email: 'fernando@ig.com.br',
                        role: 0, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/05/2024', end_date: '10/06/2024',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 5, created_by: 1, approved_by: 2)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)

    # Act
    login_as user
    visit root_path
    click_on 'Lote XPG035410'

    # Assert
    expect(page).to have_content 'Lote para leilão código XPG035410'
    expect(page).to have_content 'Data de início: 20/05/2024'
    expect(page).to have_content 'Data de término: 10/06/2024'
    expect(page).to have_content 'Lance inicial: R$ 300,00'
    expect(page).to have_content 'Diferença entre lances: R$ 50,00'
    expect(page).to have_content 'Status: Aprovado'
    expect(page).to have_content 'Criado por: john@leilaodogalpao.com.br'
    expect(page).to have_content 'Aprovado por: daniel@leilaodogalpao.com.br'
    expect(page).to have_content 'Mouse Logitech'
    expect(page).to have_content 'Mouse Gamer 1200dpi'

  end
end
