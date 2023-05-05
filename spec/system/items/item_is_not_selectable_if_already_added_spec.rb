require 'rails_helper'

describe 'Administrador visualiza um lote e tenta cadastrar um item' do

  it 'e não vê um item previamente cadastrado na caixa de seleção' do

    # Arrange
    user = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                      role: 1, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/05/2024', end_date: '10/06/2024',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 0, created_by: 1)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    second_item = Item.create!(name:'Mouse Microsoft', description:'Mouse laser sem fio', weight: 200,
                              width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)


    # Act
    login_as user
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Lotes aguardando aprovação'
    click_on 'Lote XPG035410'
    click_on 'Adicionar itens'

    # Assert
    expect(page).to have_content 'Mouse Microsoft'
    expect(page).not_to have_content 'Mouse Logitech'

  end

  it 'e não vê um item cadastrado em outro lote' do

    # Arrange
    user = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                      role: 1, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/05/2024', end_date: '10/06/2024',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 0, created_by: 1)
    second_auction_lot = AuctionLot.create!(code:'BGO570364', start_date: '20/06/2024', end_date: '10/07/2024',
                                            min_bid_amount: 500, min_bid_difference: 10, status: 0, created_by: 1)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    second_item = Item.create!(name:'Mouse Microsoft', description:'Mouse laser sem fio', weight: 200,
                              width: 6, height: 3, depth: 11, category_id: category.id)
    third_item = Item.create!(name:'Mouse Razer', description:'Mouse Razer sem fio', weight: 150,
                              width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: second_auction_lot.id, item_id: item.id)


    # Act
    login_as user
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Lotes aguardando aprovação'
    click_on 'Lote XPG035410'
    click_on 'Adicionar itens'

    # Assert
    expect(page).to have_content 'Mouse Microsoft'
    expect(page).to have_content 'Mouse Razer'
    expect(page).not_to have_content 'Mouse Logitech'

  end
end
