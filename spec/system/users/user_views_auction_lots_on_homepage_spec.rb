require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'Usuário acessa o sistema' do
  it 'e vê os lotes como usuário não autenticado' do
    # Arrange
    admin_1 = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
          role: 1, password: 'password')
    admin_2 = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
          role: 1, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: 1.day.from_now, end_date: 1.month.from_now,
                                min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin_1, approver: admin_2)
    second_auction_lot = AuctionLot.create!(code:'ABC547391', start_date: 10.days.from_now, end_date: 2.months.from_now,
                                        min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin_1, approver: admin_2)

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Lote XPG035410'
    expect(page).to have_content "Inicia em: #{1.day.from_now.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Termina em: #{1.month.from_now.strftime("%d/%m/%Y")}"
    expect(page).to have_content 'Lote ABC547391'
    expect(page).to have_content "Inicia em: #{10.days.from_now.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Termina em: #{2.months.from_now.strftime("%d/%m/%Y")}"
  end

  it 'e vê os lotes como usuário autenticado' do
    # Arrange
    admin_1 = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
          role: 1, password: 'password')
    admin_2 = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
          role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: 1.day.from_now, end_date: 1.month.from_now,
                      min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin_1, approver: admin_2)
    second_auction_lot = AuctionLot.create!(code:'ABC547391', start_date: 10.days.from_now, end_date: 2.months.from_now,
                      min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin_1, approver: admin_2)

    # Act
    login_as user
    visit root_path

    # Assert
    expect(page).to have_content 'Lote XPG035410'
    expect(page).to have_content "Inicia em: #{1.day.from_now.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Termina em: #{1.month.from_now.strftime("%d/%m/%Y")}"
    expect(page).to have_content 'Lote ABC547391'
    expect(page).to have_content "Inicia em: #{10.days.from_now.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Termina em: #{2.months.from_now.strftime("%d/%m/%Y")}"
  end
end
