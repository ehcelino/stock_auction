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
    travel_to(Time.zone.local(2023, 3, 8, 10, 10, 10)) do
    @auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '10/03/2023', end_date: '01/04/2023',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 7, creator: first_admin, approver: second_admin)
    end
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @auction_lot.id, item_id: item.id)
    travel_to(Time.zone.local(2023, 3, 12, 10, 10, 10)) do
    bid = Bid.create!(auction_lot_id: @auction_lot.id, user_id: user.id, value: 301)
    end
    travel_to(Time.zone.local(2023, 4, 8, 10, 10, 10)) do
    @second_auction_lot = AuctionLot.create!(code:'ABC035410', start_date: '20/04/2023', end_date: '01/05/2023',
                                           min_bid_amount: 300, min_bid_difference: 50, status: 7, creator: first_admin, approver: second_admin)
    end
    second_item = Item.create!(name:'Mouse Microsoft', description:'Mouse sem fio', weight: 200,
                              width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @second_auction_lot.id, item_id: second_item.id)
    travel_to(Time.zone.local(2023, 4, 22, 10, 10, 10)) do
    bid = Bid.create!(auction_lot_id: @second_auction_lot.id, user_id: user.id, value: 301)
    end

    # Act
    login_as user
    visit root_path
    click_on 'Lotes finalizados'

    # Assert
    expect(page).to have_content 'Lotes finalizados'
    expect(page).to have_content 'Lote XPG035410'
    expect(page).to have_content 'Iniciado em: 10/03/2023 Finalizado em: 01/04/2023'
    expect(page).to have_content 'Lance vencedor: Michael - R$ 301,00'
    expect(page).to have_content 'Lote ABC035410'
    expect(page).to have_content 'Iniciado em: 20/04/2023 Finalizado em: 01/05/2023'
    expect(page).to have_content 'Lance vencedor: Michael - R$ 301,00'

  end

  it 'na sua página' do

    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                              role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                                role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    travel_to(Time.zone.local(2023, 3, 8, 10, 10, 10)) do
    @auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '10/03/2023', end_date: '01/04/2023',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 7, creator: first_admin, approver: second_admin, winner: user)
    end
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @auction_lot.id, item_id: item.id)
    travel_to(Time.zone.local(2023, 3, 12, 10, 10, 10)) do
    bid = Bid.create!(auction_lot_id: @auction_lot.id, user_id: user.id, value: 301)
    end
    travel_to(Time.zone.local(2023, 4, 8, 10, 10, 10)) do
    @second_auction_lot = AuctionLot.create!(code:'ABC035410', start_date: '20/04/2023', end_date: '01/05/2023',
                                           min_bid_amount: 300, min_bid_difference: 50, status: 7, creator: first_admin, approver: second_admin, winner: user)
    end
    second_item = Item.create!(name:'Mouse Microsoft', description:'Mouse sem fio', weight: 200,
                              width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @second_auction_lot.id, item_id: second_item.id)
    travel_to(Time.zone.local(2023, 4, 22, 10, 10, 10)) do
    bid = Bid.create!(auction_lot_id: @second_auction_lot.id, user_id: user.id, value: 301)
    end

    # Act
    login_as user
    visit root_path
    click_on 'Michael - michael@ig.com.br'

    # Assert
    expect(page).to have_content 'Leilões vencedores'
    expect(page).to have_content 'Lote: XPG035410'
    expect(page).to have_content 'Valor: R$ 301,00'
    expect(page).to have_content 'Lote: ABC035410'
    expect(page).to have_content 'Valor: R$ 301,00'

  end

  it 'e vê as propriedades de um lote' do

    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                              role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                                role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    travel_to(Time.zone.local(2023, 4, 8, 10, 10, 10)) do
    @auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/04/2023', end_date: '01/05/2023',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 7, creator: first_admin, approver: second_admin)
    end
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @auction_lot.id, item_id: item.id)
    travel_to(Time.zone.local(2023, 4, 22, 10, 10, 10)) do
    bid = Bid.create!(auction_lot_id: @auction_lot.id, user_id: user.id, value: 301)
    end

    # Act
    login_as user
    visit root_path
    click_on 'Lotes finalizados'
    click_on 'Lote XPG035410'

    # Assert
    expect(page).to have_content 'Lote para leilão código XPG035410'
    expect(page).to have_content 'Status: Finalizado'
    expect(page).to have_content 'Este lote foi finalizado. Usuário vencedor: Michael - michael@ig.com.br'

  end


  it 'na badge' do

    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                              role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                                role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    travel_to(Time.zone.local(2023, 3, 8, 10, 10, 10)) do
    @auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '10/03/2023', end_date: '01/04/2023',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 7, creator: first_admin, approver: second_admin, winner: user)
    end
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @auction_lot.id, item_id: item.id)
    travel_to(Time.zone.local(2023, 3, 12, 10, 10, 10)) do
    bid = Bid.create!(auction_lot_id: @auction_lot.id, user_id: user.id, value: 301)
    end
    travel_to(Time.zone.local(2023, 4, 8, 10, 10, 10)) do
    @second_auction_lot = AuctionLot.create!(code:'ABC035410', start_date: '20/04/2023', end_date: '01/05/2023',
                                           min_bid_amount: 300, min_bid_difference: 50, status: 7, creator: first_admin, approver: second_admin, winner: user)
    end
    second_item = Item.create!(name:'Mouse Microsoft', description:'Mouse sem fio', weight: 200,
                              width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @second_auction_lot.id, item_id: second_item.id)
    travel_to(Time.zone.local(2023, 4, 22, 10, 10, 10)) do
    bid = Bid.create!(auction_lot_id: @second_auction_lot.id, user_id: user.id, value: 301)
    end

    # Act
    login_as user
    visit root_path

    # Assert
    expect(page).to have_css '#badge', text: '2'

  end

end
