require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'Admin entra no sistema' do
  it 'e lista os lotes cancelados' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                              role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                                role: 1, password: 'password')
    travel_to(Time.zone.local(2023, 4, 18, 10, 10, 10)) do
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/04/2023', end_date: '01/05/2023',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 9, creator: first_admin, approver: second_admin)
    end

    # Act
    login_as first_admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Lotes cancelados'

    # Assert
    expect(page).to have_content 'Lotes cancelados'
    expect(page).to have_content 'Lote XPG035410'
  end
end
