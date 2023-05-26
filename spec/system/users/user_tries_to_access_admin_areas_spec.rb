require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'Usuário loga na aplicação' do
  it 'e tenta acessar o cadastro de um item' do
    # Arrange
    user = User.create!(name: 'George', cpf: 62059576040, email: 'george@ig.com.br',
      role: 0, password: 'password')

    # Act
    login_as user
    visit new_item_path

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar este recurso'
  end
  it 'e tenta acessar a lista de itens' do
    # Arrange
    user = User.create!(name: 'George', cpf: 62059576040, email: 'george@ig.com.br',
      role: 0, password: 'password')

    # Act
    login_as user
    visit items_path

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar este recurso'
  end
  it 'e tenta acessar a página de categorias' do
    # Arrange
    user = User.create!(name: 'George', cpf: 62059576040, email: 'george@ig.com.br',
      role: 0, password: 'password')

    # Act
    login_as user
    visit categories_path

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar este recurso'
  end
  it 'e tenta acessar a página de criação de categoria' do
    # Arrange
    user = User.create!(name: 'George', cpf: 62059576040, email: 'george@ig.com.br',
      role: 0, password: 'password')

    # Act
    login_as user
    visit new_category_path

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar este recurso'
  end
  it 'e tenta acessar a página de criação de lote' do
    # Arrange
    user = User.create!(name: 'George', cpf: 62059576040, email: 'george@ig.com.br',
      role: 0, password: 'password')

    # Act
    login_as user
    visit new_auction_lot_path

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar este recurso'
  end
  it 'e tenta acessar a página de lotes aguardando aprovação' do
    # Arrange
    user = User.create!(name: 'George', cpf: 62059576040, email: 'george@ig.com.br',
      role: 0, password: 'password')

    # Act
    login_as user
    visit auction_lots_path

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar este recurso'
  end
  it 'e tenta acessar a página de lotes expirados' do
    # Arrange
    user = User.create!(name: 'George', cpf: 62059576040, email: 'george@ig.com.br',
      role: 0, password: 'password')

    # Act
    login_as user
    visit expired_auction_lots_path

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar este recurso'
  end
  it 'e tenta acessar a página de lotes cancelados' do
    # Arrange
    user = User.create!(name: 'George', cpf: 62059576040, email: 'george@ig.com.br',
      role: 0, password: 'password')

    # Act
    login_as user
    visit canceled_list_auction_lots_path

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar este recurso'
  end
  it 'e tenta acessar a página de listar perguntas' do
    # Arrange
    user = User.create!(name: 'George', cpf: 62059576040, email: 'george@ig.com.br',
      role: 0, password: 'password')

    # Act
    login_as user
    visit qna_index_path

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar este recurso'
  end
  it 'e tenta responder uma pergunta' do
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
    question = Qna.create!(auction_lot_id: @auction_lot.id, question: 'Este lote será entregue em minha residência?')

    # Act
    login_as user
    visit answer_auction_lot_qna_path(@auction_lot,question)

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar este recurso'
  end
  it 'e tenta acessar a página de bloqueio de CPFs' do
    # Arrange
    user = User.create!(name: 'George', cpf: 62059576040, email: 'george@ig.com.br',
      role: 0, password: 'password')

    # Act
    login_as user
    visit blocked_cpfs_path

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar este recurso'
  end
  it 'e tenta acessar a página de bloquear um CPF' do
    # Arrange
    user = User.create!(name: 'George', cpf: 62059576040, email: 'george@ig.com.br',
      role: 0, password: 'password')

    # Act
    login_as user
    visit new_blocked_cpf_path

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar este recurso'
  end
end
