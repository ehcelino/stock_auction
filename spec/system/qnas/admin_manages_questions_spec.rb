require 'rails_helper'

describe 'Administrador entra no sistema' do
  it 'e responde uma pergunta' do
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
    Qna.create!(auction_lot_id: auction_lot.id, question: 'Este lote será entregue em minha residência?')

    # Act
    login_as first_admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Responder perguntas'
    find(:css, '#qna_1').click # link responder
    fill_in 'Resposta', with: 'Não, ele deve ser retirado na empresa.'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Resposta gravada com sucesso'
    expect(page).to have_content 'Pergunta: Este lote será entregue em minha residência?'
    expect(page).to have_content 'Resposta: Não, ele deve ser retirado na empresa.'

  end

  it 'e oculta uma pergunta' do
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
    Qna.create!(auction_lot_id: auction_lot.id, question: 'Este lote será entregue em minha residência?')

    # Act
    login_as first_admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Responder perguntas'
    find(:css, '#ocultar-qna_1').click # botão ocultar

    # Assert
    expect(page).to have_content 'Pergunta oculta por administrador'
  end

end
