require 'rails_helper'

describe 'Admin cria um novo lote' do

  it 'com sucesso' do

    # Arrange
    user = User.create!(name: 'João', cpf: 62053621044, email: 'joao@leilaodogalpao.com.br', role: 1, password: 'password')

    # Act
    login_as user
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Novo lote para leilão'
    fill_in 'Código', with: 'ABC123456'
    fill_in 'Data de início', with: 10.days.from_now
    fill_in 'Data de término', with: 1.month.from_now
    fill_in 'Lance inicial', with: 100
    fill_in 'Diferença entre lances', with: 50
    click_on 'Criar lote'

    # Assert
    expect(page).to have_content 'Lote criado com sucesso'
    expect(page).to have_content 'Lote para leilão código ABC123456'
    expect(page).to have_content "Data de início: #{10.days.from_now.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Data de término: #{1.month.from_now.strftime("%d/%m/%Y")}"
    expect(page).to have_content 'Lance inicial: R$ 100,00'
    expect(page).to have_content 'Diferença entre lances: R$ 50,00'
    expect(page).to have_content 'Status: Aguardando aprovação'
    expect(page).to have_content 'Criado por: joao@leilaodogalpao.com.br'

  end

  it 'e cria um código inválido' do

    # Arrange
    user = User.create!(name: 'João', cpf: 62053621044, email: 'joao@leilaodogalpao.com.br', role: 1, password: 'password')

    # Act
    login_as user
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Novo lote para leilão'
    fill_in 'Código', with: '123456ABC'
    fill_in 'Data de início', with: 10.days.from_now
    fill_in 'Data de término', with: 1.month.from_now
    fill_in 'Lance inicial', with: 100
    fill_in 'Diferença entre lances', with: 50
    click_on 'Criar lote'

    # Assert
    expect(page).to have_content 'Lote inválido'
    expect(page).to have_content 'Código inválido'

  end


  it 'e usa uma data de início inválida' do

    # Arrange
    user = User.create!(name: 'João', cpf: 62053621044, email: 'joao@leilaodogalpao.com.br', role: 1, password: 'password')

    # Act
    login_as user
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Novo lote para leilão'
    fill_in 'Código', with: 'ABC123456'
    fill_in 'Data de início', with: '20/04/2023'
    fill_in 'Data de término', with: '30/04/2023'
    fill_in 'Lance inicial', with: 100
    fill_in 'Diferença entre lances', with: 50
    click_on 'Criar lote'

    # Assert
    expect(page).to have_content 'Lote inválido'
    expect(page).to have_content 'Data de início deve ser futura'

  end

  it 'e não preenche todos os campos' do

    # Arrange
    user = User.create!(name: 'João', cpf: 62053621044, email: 'joao@leilaodogalpao.com.br', role: 1, password: 'password')

    # Act
    login_as user
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Novo lote para leilão'
    fill_in 'Código', with: ''
    fill_in 'Data de início', with: ''
    fill_in 'Data de término', with: ''
    fill_in 'Lance inicial', with: ''
    fill_in 'Diferença entre lances', with: ''
    click_on 'Criar lote'

    # Assert
    expect(page).to have_content 'Lote inválido'
    expect(page).to have_content 'Código não pode ficar em branco'
    expect(page).to have_content 'Data de início não pode ficar em branco'
    expect(page).to have_content 'Data de término não pode ficar em branco'
    expect(page).to have_content 'Lance inicial não pode ficar em branco'
    expect(page).to have_content 'Diferença entre lances não pode ficar em branco'

  end


end
