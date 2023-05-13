require 'rails_helper'

describe 'Administrador abre um lote' do
  it 'e edita seus parâmetros com sucesso' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                              role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                                role: 1, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/04/2023', end_date: 1.month.from_now,
                                    min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: first_admin, approver: second_admin)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)

    # Act
    login_as first_admin
    visit root_path
    click_on 'Lote XPG035410'
    click_on 'Editar lote'
    fill_in 'Lance inicial', with: 100
    fill_in 'Diferença entre lances', with: 10
    click_on 'Atualizar lote'

    # Assert
    expect(page).to have_content 'Lote atualizado com sucesso'
    expect(page).to have_content 'Lote para leilão código XPG035410'
    expect(page).to have_content 'Lance inicial: R$ 100,00'
    expect(page).to have_content 'Diferença entre lances: R$ 10,00'

  end

  it 'e edita seus parâmetros com erro' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                              role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                                role: 1, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/04/2023', end_date: 1.month.from_now,
                                    min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: first_admin, approver: second_admin)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)

    # Act
    login_as first_admin
    visit root_path
    click_on 'Lote XPG035410'
    click_on 'Editar lote'
    fill_in 'Data de início', with: '20/05/2023'
    fill_in 'Data de término', with: '19/05/2023'
    fill_in 'Lance inicial', with: 0
    fill_in 'Diferença entre lances', with: 10
    click_on 'Atualizar lote'

    # Assert
    expect(page).to have_content 'Lote inválido'
    expect(page).to have_content 'Data de término deve ser maior que a data de início'
    expect(page).to have_content 'Lance inicial deve ser maior que 1'

  end
end
