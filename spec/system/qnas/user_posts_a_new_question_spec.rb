require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'Usuário entra no sistema' do
  it 'e faz uma pergunta em um lote com sucesso' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
          role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
            role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
    role: 0, password: 'password')
    travel_to(1.month.ago) do
    @auction_lot = AuctionLot.create!(code:'XPG035410', start_date: 1.day.from_now, end_date: 2.months.from_now,
                min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: first_admin, approver: second_admin)
    end
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
    width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @auction_lot.id, item_id: item.id)
    Bid.create!(auction_lot_id: @auction_lot.id, user_id: user.id, value: 301)
    travel_to(1.month.ago) do
    @second_auction_lot = AuctionLot.create!(code:'ABC035410', start_date: 1.day.from_now, end_date: 2.months.from_now,
    min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: first_admin, approver: second_admin)
    end
    second_item = Item.create!(name:'Mouse Microsoft', description:'Mouse sem fio', weight: 200,
    width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @second_auction_lot.id, item_id: second_item.id)
    Bid.create!(auction_lot_id: @second_auction_lot.id, user_id: user.id, value: 301)

    # Act
    login_as user
    visit root_path
    click_on 'Lote XPG035410'
    click_on 'Fazer uma pergunta'
    fill_in 'Pergunta', with: 'Este lote será entregue em minha residência?'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Sua pergunta foi registrada'
    expect(page).to have_content 'Pergunta: Este lote será entregue em minha residência?'
    expect(page).to have_content 'Resposta:'

  end

  it 'e faz uma pergunta com erro' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
          role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
            role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
    role: 0, password: 'password')
    travel_to(1.month.ago) do
    @auction_lot = AuctionLot.create!(code:'XPG035410', start_date: 1.day.from_now, end_date: 2.months.from_now,
                min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: first_admin, approver: second_admin)
    end
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
    width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @auction_lot.id, item_id: item.id)
    Bid.create!(auction_lot_id: @auction_lot.id, user_id: user.id, value: 301)
    travel_to(1.month.ago) do
    @second_auction_lot = AuctionLot.create!(code:'ABC035410', start_date: 1.day.from_now, end_date: 2.months.from_now,
    min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: first_admin, approver: second_admin)
    end
    second_item = Item.create!(name:'Mouse Microsoft', description:'Mouse sem fio', weight: 200,
    width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @second_auction_lot.id, item_id: second_item.id)
    Bid.create!(auction_lot_id: @second_auction_lot.id, user_id: user.id, value: 301)

    # Act
    login_as user
    visit root_path
    click_on 'Lote XPG035410'
    click_on 'Fazer uma pergunta'
    fill_in 'Pergunta', with: ''
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Ocorreu um erro'
    expect(page).to have_content 'Pergunta não pode ficar em branco.'

  end

  it 'e vê uma resposta' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
      role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
            role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
    role: 0, password: 'password')
    travel_to(1.month.ago) do
    @auction_lot = AuctionLot.create!(code:'XPG035410', start_date: 1.day.from_now, end_date: 2.months.from_now,
                min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: first_admin, approver: second_admin)
    end
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
    width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @auction_lot.id, item_id: item.id)
    Bid.create!(auction_lot_id: @auction_lot.id, user_id: user.id, value: 301)
    travel_to(1.month.ago) do
    @second_auction_lot = AuctionLot.create!(code:'ABC035410', start_date: 1.day.from_now, end_date: 2.months.from_now,
    min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: first_admin, approver: second_admin)
    end
    second_item = Item.create!(name:'Mouse Microsoft', description:'Mouse sem fio', weight: 200,
    width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @second_auction_lot.id, item_id: second_item.id)
    Bid.create!(auction_lot_id: @second_auction_lot.id, user_id: user.id, value: 301)
    Qna.create!(auction_lot_id: @auction_lot.id, question: 'Este lote será entregue em minha residência?',
                answer: 'Não, ele deve ser retirado na empresa.', user_id: first_admin.id)

    # Act
    login_as user
    visit root_path
    click_on 'Lote XPG035410'

    # Assert
    expect(page).to have_content 'Perguntas e respostas'
    expect(page).to have_content 'Pergunta: Este lote será entregue em minha residência?'
    expect(page).to have_content 'Resposta: Não, ele deve ser retirado na empresa.'
    expect(page).to have_content 'Respondida por: john@leilaodogalpao.com.br'

  end

  it 'e não vê uma pergunta oculta' do
    # Arrange
    first_admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
          role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
            role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
    role: 0, password: 'password')
    travel_to(1.month.ago) do
    @auction_lot = AuctionLot.create!(code:'XPG035410', start_date: 1.day.from_now, end_date: 2.months.from_now,
                min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: first_admin, approver: second_admin)
    end
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
    width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @auction_lot.id, item_id: item.id)
    Bid.create!(auction_lot_id: @auction_lot.id, user_id: user.id, value: 301)
    travel_to(1.month.ago) do
    @second_auction_lot = AuctionLot.create!(code:'ABC035410', start_date: 1.day.from_now, end_date: 2.months.from_now,
    min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: first_admin, approver: second_admin)
    end
    second_item = Item.create!(name:'Mouse Microsoft', description:'Mouse sem fio', weight: 200,
    width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @second_auction_lot.id, item_id: second_item.id)
    Bid.create!(auction_lot_id: @second_auction_lot.id, user_id: user.id, value: 301)
    Qna.create!(auction_lot_id: @auction_lot.id, question: 'Este lote será entregue em minha residência?', status: "hidden")

    # Act
    login_as user
    visit root_path
    click_on 'Lote XPG035410'

    # Assert
    expect(page).not_to have_content 'Questão: Este lote será entregue em minha residência?'

  end
end
