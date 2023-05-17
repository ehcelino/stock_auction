require 'rails_helper'

describe 'Administrador acessa um lote' do

  it 'e cadastra um item' do

    # Arrange
    admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                       role: 1, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: 1.day.from_now, end_date: 1.month.from_now,
                                    min_bid_amount: 300, min_bid_difference: 50, status: 0, creator: admin)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    second_item = Item.create!(name:'Mouse Microsoft', description:'Mouse laser sem fio', weight: 200,
                               width: 6, height: 3, depth: 11, category_id: category.id)

    # Act
    login_as admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Lotes aguardando aprovação'
    click_on 'Lote XPG035410'
    click_on 'Adicionar itens'
    select 'Mouse Logitech', from: 'Item'
    click_on 'Adicionar item'

    # Assert
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content 'Lote para leilão código XPG035410'
    expect(page).to have_content "Data de início: #{1.day.from_now.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Data de término: #{1.month.from_now.strftime("%d/%m/%Y")}"
    expect(page).to have_content 'Lance inicial: R$ 300,00'
    expect(page).to have_content 'Diferença entre lances: R$ 50,00'
    expect(page).to have_content 'Mouse Logitech'
    expect(page).to have_content 'Mouse Gamer 1200dpi'
    expect(page).to have_content '200 g.'
    expect(page).to have_content '6 x 3 x 11 cm'
    expect(page).to have_content 'Informática'

  end

  it 'e tenta anexar um item mas não há mais disponíveis' do
    # Arrange
    admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                        role: 1, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: 1.day.from_now, end_date: 1.month.from_now,
                                    min_bid_amount: 300, min_bid_difference: 50, status: 0, creator: admin)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)

    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)

    # Act
    login_as admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Lotes aguardando aprovação'
    click_on 'Lote XPG035410'
    click_on 'Adicionar itens'

    # Assert
    expect(page).to have_content 'Não existem itens para anexar ao lote'
  end
end
