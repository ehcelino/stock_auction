require 'rails_helper'

describe 'Usuário entra no sistema' do
  it 'e adiciona um lote aos favoritos' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
      role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
            role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
    role: 0, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/04/2023', end_date: 1.month.from_now,
                min_bid_amount: 300, min_bid_difference: 50, status: 5, created_by: first_admin.id, approved_by: second_admin.id)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
    width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)
    Bid.create!(auction_lot_id: auction_lot.id, user_id: user.id, value: 301)
    second_auction_lot = AuctionLot.create!(code:'ABC035410', start_date: '20/04/2023', end_date: 1.month.from_now,
                      min_bid_amount: 300, min_bid_difference: 50, status: 5, created_by: first_admin.id, approved_by: second_admin.id)
    second_item = Item.create!(name:'Mouse Microsoft', description:'Mouse sem fio', weight: 200,
          width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: second_auction_lot.id, item_id: second_item.id)
    Bid.create!(auction_lot_id: second_auction_lot.id, user_id: user.id, value: 301)

    # Act
    login_as user
    visit root_path
    click_on 'Lote XPG035410'
    click_on 'Adicionar aos favoritos'
    click_on 'Michael - michael@ig.com.br'

    # Assert
    expect(page).to have_content 'Lotes favoritos'
    expect(page).to have_content 'Lote XPG035410'

  end

  it 'e retira um lote dos favoritos' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
      role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
            role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
    role: 0, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/04/2023', end_date: 1.month.from_now,
                min_bid_amount: 300, min_bid_difference: 50, status: 5, created_by: first_admin.id, approved_by: second_admin.id)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
    width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)
    Bid.create!(auction_lot_id: auction_lot.id, user_id: user.id, value: 301)
    second_auction_lot = AuctionLot.create!(code:'ABC035410', start_date: '20/04/2023', end_date: 1.month.from_now,
                      min_bid_amount: 300, min_bid_difference: 50, status: 5, created_by: first_admin.id, approved_by: second_admin.id)
    second_item = Item.create!(name:'Mouse Microsoft', description:'Mouse sem fio', weight: 200,
          width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: second_auction_lot.id, item_id: second_item.id)
    Bid.create!(auction_lot_id: second_auction_lot.id, user_id: user.id, value: 301)
    Favorite.create!(user_id: user.id, auction_lot_id: auction_lot.id)

    # Act
    login_as user
    visit user_path(user)
    click_on 'Lote XPG035410'
    click_on 'Remover dos favoritos'

    # Assert
    expect(page).to have_content 'Lote removido dos favoritos'

  end

  it 'e vê um lote vencido nos favoritos' do
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
    second_auction_lot = AuctionLot.create!(code:'ABC035410', start_date: '20/04/2023', end_date: 1.month.from_now,
                      min_bid_amount: 300, min_bid_difference: 50, status: 5, created_by: first_admin.id, approved_by: second_admin.id)
    second_item = Item.create!(name:'Mouse Microsoft', description:'Mouse sem fio', weight: 200,
          width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: second_auction_lot.id, item_id: second_item.id)
    Bid.create!(auction_lot_id: second_auction_lot.id, user_id: user.id, value: 301)
    Favorite.create!(user_id: user.id, auction_lot_id: auction_lot.id)

    # Act
    login_as user
    visit user_path(user)

    # Assert
    expect(page).to have_content 'Lotes favoritos'
    expect(page).to have_content 'Lote XPG035410'
    expect(page).to have_content '(vencido)'

  end

end
