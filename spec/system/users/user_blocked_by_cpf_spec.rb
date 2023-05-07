require 'rails_helper'

describe 'Administrador bloqueia um CPF' do
  it 'adicionando o cpf ao sistema' do
    # Arrange
    admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                        role: 1, password: 'password')

    # Act
    login_as admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Bloqueio de CPF'
    click_on 'Adicionar CPF à lista de bloqueio'
    fill_in 'CPF', with: '59494419073'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'CPF adicionado à lista de bloqueio'
    expect(page).to have_content 'Lista de CPFs bloqueados no sistema'
    expect(page).to have_content '594.944.190-73'
  end

  it 'e usuário não consegue se cadastrar' do
    # Arrange
    BlockedCpf.create!(cpf: 59494419073)

    # Act
    visit root_path
    click_on 'Cadastrar'
    within('form') do
      fill_in 'E-mail', with: 'joao@ig.com.br'
      fill_in 'Nome', with: 'João'
      fill_in 'CPF', with: '59494419073'
      fill_in 'Senha', with: 'password'
      fill_in 'Confirme sua senha', with: 'password'
      click_on 'Criar conta'
    end

    # Assert
    expect(page).to have_content 'Não foi possível salvar usuário: 1 erro'
    expect(page).to have_content 'CPF está bloqueado para criação de nova conta'
  end

  it 'e usuário tem sua conta bloqueada' do
    # Arrange
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    BlockedCpf.create!(cpf: 62059576040)

    # Act
    login_as user
    visit root_path

    # Assert
    expect(page).to have_content 'Seu usuário está bloqueado para as funções do site. Fale com seu administrador.'
  end

  it 'e usuário não pode dar lances' do
    # Arrange
    User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                role: 1, password: 'password')
    User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                role: 1, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: '20/05/2024', end_date: '10/06/2024',
                              min_bid_amount: 300, min_bid_difference: 50, status: 5, created_by: 1, approved_by: 2)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    BlockedCpf.create!(cpf: 62059576040)

    # Act
    login_as user
    visit root_path
    click_on 'Lote XPG035410'

    # Assert
    expect(page).to have_content 'Seu usuário está bloqueado para as funções do site. Fale com seu administrador.'
    expect(page).not_to have_link 'Dar um lance'
  end


end
