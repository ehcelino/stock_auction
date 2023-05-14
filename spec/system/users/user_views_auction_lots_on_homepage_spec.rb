require 'rails_helper'

describe 'Usuário acessa o sistema' do
  it 'e vê os lotes como usuário não autenticado' do
    # Arrange
    admin_1 = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
          role: 1, password: 'password')
    admin_2 = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
          role: 1, password: 'password')
    auction_lot = AuctionLot.new(code:'XPG035410', start_date: '20/04/2023', end_date: '10/06/2023',
                                min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin_1, approver: admin_2)
    auction_lot.save!(validate: false)
    second_auction_lot = AuctionLot.new(code:'ABC547391', start_date: '01/07/2023', end_date: '10/08/2023',
                                        min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin_1, approver: admin_2)
    second_auction_lot.save!(validate: false)

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Lote XPG035410'
    expect(page).to have_content 'Iniciado em: 20/04/2023'
    expect(page).to have_content 'Termina em: 10/06/2023'
    expect(page).to have_content 'Lote ABC547391'
    expect(page).to have_content 'Inicia em: 01/07/2023'
    expect(page).to have_content 'Termina em: 10/08/2023'
  end

  it 'e vê os lotes como usuário autenticado' do
    # Arrange
    admin_1 = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
          role: 1, password: 'password')
    admin_2 = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
          role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    auction_lot = AuctionLot.new(code:'XPG035410', start_date: '20/04/2023', end_date: '10/06/2023',
                      min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin_1, approver: admin_2)
    auction_lot.save!(validate: false)
    second_auction_lot = AuctionLot.new(code:'ABC547391', start_date: '01/07/2023', end_date: '10/08/2023',
                      min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin_1, approver: admin_2)
    second_auction_lot.save!(validate: false)

    # Act
    login_as user
    visit root_path

    # Assert
    expect(page).to have_content 'Lote XPG035410'
    expect(page).to have_content 'Iniciado em: 20/04/2023'
    expect(page).to have_content 'Termina em: 10/06/2023'
    expect(page).to have_content 'Lote ABC547391'
    expect(page).to have_content 'Inicia em: 01/07/2023'
    expect(page).to have_content 'Termina em: 10/08/2023'
  end
end
