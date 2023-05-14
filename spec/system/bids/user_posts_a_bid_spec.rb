require 'rails_helper'

describe 'Usuário vê um leilão e dá um lance' do
  it 'com sucesso' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                              role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                                role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                       role: 0, password: 'password')
    auction_lot = AuctionLot.new(code:'XPG035410', start_date: '20/04/2023', end_date: '10/06/2023',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: first_admin, approver: second_admin)
    auction_lot.save!(validate: false)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)

    # Act
    login_as user
    visit root_path
    click_on 'Lote XPG035410'
    click_on 'Dar um lance'
    fill_in 'Valor', with: '301'
    click_on 'Confirmar lance'

    # Assert
    expect(page).to have_content 'Lance registrado com sucesso'
    expect(page).to have_content 'Michael - R$ 301,00'
    expect(auction_lot.bids.count).to eq 1
  end

  it 'depois de outro lance' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
          role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
            role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    second_user = User.create!(name: 'Douglas', cpf: 36318417010, email: 'douglas@ig.com.br',
                               role: 0, password: 'password')
    auction_lot = AuctionLot.new(code:'XPG035410', start_date: '20/04/2023', end_date: '10/06/2023',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: first_admin, approver: second_admin)
    auction_lot.save!(validate: false)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)
    Bid.create!(auction_lot_id: auction_lot.id, user_id: user.id, value: 301)

    # Act
    login_as second_user
    visit root_path
    click_on 'Lote XPG035410'
    click_on 'Dar um lance'
    fill_in 'Valor', with: '351'
    click_on 'Confirmar lance'


    # Assert
    expect(page).to have_content 'Lance registrado com sucesso'
    expect(page).to have_content 'Michael - R$ 301,00'
    expect(page).to have_content 'Douglas - R$ 351,00 Lance vencedor no momento'
    expect(auction_lot.bids.count).to eq 2
  end

  it 'com valor menor que o valor inicial' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                              role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                                role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                       role: 0, password: 'password')
    auction_lot = AuctionLot.new(code:'XPG035410', start_date: '20/04/2023', end_date: '10/06/2023',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: first_admin, approver: second_admin)
    auction_lot.save!(validate: false)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)

    # Act
    login_as user
    visit root_path
    click_on 'Lote XPG035410'
    click_on 'Dar um lance'
    fill_in 'Valor', with: '299'
    click_on 'Confirmar lance'

    # Assert
    expect(page).to have_content 'Valor menor que o valor mínimo para este lance'
  end

  it 'com valor menor que o valor do segundo lance' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
          role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
            role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    second_user = User.create!(name: 'Douglas', cpf: 36318417010, email: 'douglas@ig.com.br',
                               role: 0, password: 'password')
    auction_lot = AuctionLot.new(code:'XPG035410', start_date: '20/04/2023', end_date: '10/06/2023',
                                    min_bid_amount: 100, min_bid_difference: 2, status: 5, creator: first_admin, approver: second_admin)
    auction_lot.save!(validate: false)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)
    Bid.create!(auction_lot_id: auction_lot.id, user_id: user.id, value: 101)

    # Act
    login_as second_user
    visit root_path
    click_on 'Lote XPG035410'
    click_on 'Dar um lance'
    fill_in 'Valor', with: '102'
    click_on 'Confirmar lance'


    # Assert
    expect(page).to have_content 'Valor menor que o valor mínimo para este lance'
  end

end

describe 'Usuário tenta postar um lance' do
  it 'e o lote foi expirado' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                              role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                                role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    auction_lot = AuctionLot.new(code:'XPG035410', start_date: '20/04/2023', end_date: '05/05/2023',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: first_admin, approver: second_admin)
    auction_lot.save!(validate: false)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)

    # Act
    login_as user
    visit root_path

    # Assert
    expect(page).not_to have_link 'Lote XPG035410'
  end

  it 'através da página de um lote expirado' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                              role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                                role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    auction_lot = AuctionLot.new(code:'XPG035410', start_date: '20/04/2023', end_date: '05/05/2023',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: first_admin, approver: second_admin)
    auction_lot.save!(validate: false)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)

    # Act
    login_as user
    visit new_auction_lot_bid_path(auction_lot)
    fill_in 'Valor', with: 350
    click_on 'Confirmar lance'

    # Assert
    expect(page).to have_content 'Não foi possível registrar seu lance'
    expect(page).to have_content 'Este leilão não pode receber novos lances'
  end
end
