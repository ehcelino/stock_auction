require 'rails_helper'

describe 'Admin cancela um lote' do
  it 'e libera os itens deste lote' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                              role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                                role: 1, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/04/2023', end_date: '01/05/2023',
                                    min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: first_admin, approver: second_admin)
    AuctionLot.create!(code:'ABC035410', start_date: '20/06/2023', end_date: '01/07/2023',
                      min_bid_amount: 300, min_bid_difference: 50, status: 0, creator: first_admin)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)

    # Act
    login_as first_admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Lotes expirados'
    click_on 'XPG035410'
    click_on 'Cancelar o lote'
    click_on 'Funções administrativas'
    click_on 'Lotes aguardando aprovação'
    click_on 'Lote ABC035410'
    click_on 'Adicionar itens'

    # Assert
    expect(page).to have_content 'Adicionar item ao lote ABC035410'
    expect(page).to have_content 'Mouse Logitech'

  end

end
