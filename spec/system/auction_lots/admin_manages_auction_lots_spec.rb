require 'rails_helper'

describe 'Admin vê os lotes aguardando aprovação' do

  it 'e tenta aprovar um lote sem ítens' do

    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                               role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                               role: 1, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/05/2024', end_date: '10/06/2024',
                                     min_bid_amount: 300, min_bid_difference: 50, status: 0, created_by: first_admin.id)
    category = Category.create!(name:'Informática')

    # Act
    login_as second_admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Lotes aguardando aprovação'
    click_on 'Lote XPG035410'
    click_on 'Aprovar lote'

    # Assert
    expect(page).to have_content 'Um lote não pode ser aprovado sem itens'
    expect(page).to have_content 'Este lote ainda não possui itens cadastrados'

  end

  it 'e tenta aprovar um lote criado por ele mesmo' do

    # Arrange
    admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                        role: 1, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/05/2024', end_date: '10/06/2024',
                              min_bid_amount: 300, min_bid_difference: 50, status: 0, created_by: admin.id)

    # Act
    login_as admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Lotes aguardando aprovação'
    click_on 'Lote XPG035410'
    click_on 'Aprovar lote'

    # Assert
    expect(page).to have_content 'Um lote não pode ser aprovado pelo usuário que o criou'
    expect(page).to have_content 'Status: Aguardando aprovação'

  end

  it 'e aprova o lote' do

    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                               role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                                role: 1, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/05/2024', end_date: '10/06/2024',
                              min_bid_amount: 300, min_bid_difference: 50, status: 0, created_by: first_admin.id)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                  width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)

    # Act
    login_as second_admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Lotes aguardando aprovação'
    click_on 'Lote XPG035410'
    click_on 'Aprovar lote'

    # Assert
    expect(page).to have_content 'Este lote foi aprovado com sucesso'
    expect(page).to have_content 'Status: Aprovado'

  end

end
