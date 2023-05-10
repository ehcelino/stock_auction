require 'rails_helper'

describe 'Usuário acessa o sistema e se cadastra' do
  it 'com sucesso' do

    # Arrange

    # Act
    visit root_path
    click_on 'Cadastrar'
    fill_in 'E-mail', with: 'joao@ig.com.br'
    fill_in 'Nome', with: 'João'
    fill_in 'CPF', with: '62059576040'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'

    # Assert
    expect(page).to have_content 'Leilão do Galpão'
    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    within('nav') do
      expect(page).to have_content 'João - joao@ig.com.br'
      expect(page).to have_button 'Sair'
    end

  end

  it 'com CPF inválido' do

    # Arrange

    # Act
    visit root_path
    click_on 'Cadastrar'
    fill_in 'E-mail', with: 'joao@ig.com.br'
    fill_in 'Nome', with: 'João'
    fill_in 'CPF', with: '62059576041'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'

    # Assert
    expect(page).to have_content 'Leilão do Galpão'
    expect(page).to have_content 'Não foi possível salvar usuário'
    expect(page).to have_content 'CPF inválido'

  end

  it 'com CPF duplicado' do

    # Arrange
    User.create!(name: 'João', cpf: 62053621044, email: 'joao@leilaodogalpao.com.br', role: 1, password: 'password')

    # Act
    visit root_path
    click_on 'Cadastrar'
    fill_in 'E-mail', with: 'michael@ig.com.br'
    fill_in 'Nome', with: 'Michael'
    fill_in 'CPF', with: '62053621044'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'

    # Assert
    expect(page).to have_content 'Leilão do Galpão'
    expect(page).to have_content 'Não foi possível salvar usuário'
    expect(page).to have_content 'CPF já está em uso'

  end

  it 'com email de administrador' do

    # Arrange

    # Act
    visit root_path
    click_on 'Cadastrar'
    fill_in 'E-mail', with: 'joao@leilaodogalpao.com.br'
    fill_in 'Nome', with: 'João'
    fill_in 'CPF', with: '62059576040'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'

    # Assert
    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    within('nav') do
      expect(page).to have_content 'João - joao@leilaodogalpao.com.br (ADMIN)'
      expect(page).to have_button 'Sair'
    end
  end

end
