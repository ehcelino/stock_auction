require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

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
    fill_in 'E-mail', with: 'joao@ig.com.br'
    fill_in 'Nome', with: 'João'
    fill_in 'CPF', with: '59494419073'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'

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
    visit new_user_session_path
    fill_in 'E-mail', with: 'michael@ig.com.br'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar no sistema'

    # Assert
    expect(page).to have_content 'Atenção: seu usuário está bloqueado. Fale com um administrador.'
  end

  it 'e usuário não pode dar lances' do
    # Arrange
    admin_1 = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                role: 1, password: 'password')
    admin_2 = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                role: 1, password: 'password')
    travel_to(1.month.ago) do
    @auction_lot = AuctionLot.create!(code:'XPG035410', start_date: 1.day.from_now, end_date: 2.months.from_now,
                              min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin_1, approver: admin_2)
    end
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @auction_lot.id, item_id: item.id)
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    BlockedCpf.create!(cpf: 62059576040)

    # Act
    visit new_user_session_path
    fill_in 'E-mail', with: 'michael@ig.com.br'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar no sistema'
    visit root_path
    click_on 'Lote XPG035410'

    # Assert
    expect(page).not_to have_link 'Dar um lance'
  end

  it 'e usuário não pode dar lances mesmo da página de lance' do
    # Arrange
    admin_1 = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                role: 1, password: 'password')
    admin_2 = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                role: 1, password: 'password')
    travel_to(1.month.ago) do
    @auction_lot = AuctionLot.create!(code:'XPG035410', start_date: 1.day.from_now, end_date: 2.months.from_now,
                              min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin_1, approver: admin_2)
    end
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @auction_lot.id, item_id: item.id)
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    BlockedCpf.create!(cpf: 62059576040)

    # Act
    login_as user
    visit new_auction_lot_bid_path(@auction_lot)
    fill_in 'Valor', with: '350'
    click_on 'Confirmar lance'

    # Assert
    expect(page).to have_content 'Usuários bloqueados não podem fazer lances'
  end

  it 'e usuário não consegue acessar a página de lances' do
    # Arrange
    admin_1 = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                role: 1, password: 'password')
    admin_2 = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                role: 1, password: 'password')
    travel_to(1.month.ago) do
    @auction_lot = AuctionLot.create!(code:'XPG035410', start_date: 1.day.from_now, end_date: 2.months.from_now,
                              min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin_1, approver: admin_2)
    end
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @auction_lot.id, item_id: item.id)
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password', status: 5)
    BlockedCpf.create!(cpf: 62059576040)

    # Act
    login_as(user)
    get(new_auction_lot_bid_path(@auction_lot))

    # Assert
    expect(response).to redirect_to(root_path)
  end

  it 'e usuário não pode fazer perguntas' do
    # Arrange
    admin_1 = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                role: 1, password: 'password')
    admin_2 = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                role: 1, password: 'password')
    auction_lot = AuctionLot.create!(code:'XPG035410', start_date: 1.day.from_now, end_date: 1.month.from_now,
                              min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin_1, approver: admin_2)
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: auction_lot.id, item_id: item.id)
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    BlockedCpf.create!(cpf: 62059576040)

    # Act
    visit new_user_session_path
    fill_in 'E-mail', with: 'michael@ig.com.br'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar no sistema'
    visit root_path
    click_on 'Lote XPG035410'

    # Assert
    expect(page).not_to have_link 'Fazer uma pergunta'
  end


end

describe 'Admin retira um cpf da lista de bloqueio' do
  it 'e usuário volta a ter privilégios' do
    # Arrange
    admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
          role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                  role: 0, password: 'password')
    BlockedCpf.create!(cpf: 62059576040)

    # Act
    login_as admin
    visit blocked_cpfs_path
    find(:css, '#remove-blocked_cpf_1').click
    logout(admin)
    login_as user
    visit root_path

    # Assert
    expect(user.normal?).to eq true
  end
end
