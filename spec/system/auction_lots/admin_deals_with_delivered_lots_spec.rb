require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'Administrador entra no sistema' do
  it 'e marca lote finalizado como entregue' do

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

    # Act
    login_as first_admin
    visit root_path
    click_on 'Lotes finalizados'
    click_on 'Lote XPG035410'
    click_on 'Marcar como entregue'

    #Assert
    expect(page).to have_content 'Lote marcado como entregue'
    expect(page).to have_content 'Status: Entregue'
  end

  it 'e vê lista de lotes entregues' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
          role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
            role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
    role: 0, password: 'password')
    travel_to(Time.zone.local(2023, 3, 8, 10, 10, 10)) do
    @auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '10/03/2023', end_date: '01/04/2023',
                min_bid_amount: 300, min_bid_difference: 50, status: 8, creator: first_admin, approver: second_admin, winner: user)
    end
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
    width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @auction_lot.id, item_id: item.id)
    travel_to(Time.zone.local(2023, 3, 12, 10, 10, 10)) do
    bid = Bid.create!(auction_lot_id: @auction_lot.id, user_id: user.id, value: 301)
    end

    # Act
    login_as first_admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Lotes entregues'

    #Assert
    expect(page).to have_content 'Lotes entregues'
    expect(page).to have_content 'Lote XPG035410'
  end
end
