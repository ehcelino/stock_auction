require 'rails_helper'

describe 'Administrador visualiza um lote e tenta cadastrar um item' do

  it 'e não vê um item já vendido na caixa de seleção' do

    # Arrange
    admin_1 = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                           role: 1, password: 'password')
    admin_2 = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                          role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/05/2024', end_date: '10/06/2024',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 0, creator: admin_1)
    second_auction_lot = AuctionLot.create!(code:'BGO570364', start_date: '20/03/2024', end_date: '10/04/2024',
                                            min_bid_amount: 500, min_bid_difference: 10, status: 7, creator: admin_1, approver: admin_2)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    second_item = Item.create!(name:'Mouse Microsoft', description:'Mouse laser sem fio', weight: 200,
                              width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: second_auction_lot.id, item_id: item.id)
    bid = Bid.new(auction_lot_id: second_auction_lot.id, user_id: user.id, value: 510)
    bid.save!(validate: false)


    # Act
    login_as admin_1
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
    admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                      role: 1, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/05/2024', end_date: '10/06/2024',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 0, creator: admin)
    second_auction_lot = AuctionLot.create!(code:'BGO570364', start_date: '20/06/2024', end_date: '10/07/2024',
                                            min_bid_amount: 500, min_bid_difference: 10, status: 0, creator: admin)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    second_item = Item.create!(name:'Mouse Microsoft', description:'Mouse laser sem fio', weight: 200,
                              width: 6, height: 3, depth: 11, category_id: category.id)
    third_item = Item.create!(name:'Mouse Razer', description:'Mouse Razer sem fio', weight: 150,
                              width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: second_auction_lot.id, item_id: item.id)


    # Act
    login_as admin
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
