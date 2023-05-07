require 'rails_helper'

describe 'Usuário acessa o sistema' do
  it 'e acessa via login' do

    # Arrange
    User.create!(name: 'João', cpf: 62053621044, email: 'joao@ig.com.br', role: 0, password: 'password')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'joao@ig.com.br'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar no sistema'

    # Assert
    expect(page).to have_content 'Login efetuado com sucesso.'
    within('nav') do
      expect(page).to have_content 'João - joao@ig.com.br'
      expect(page).to have_button 'Sair'
    end


  end

  it 'e é um administrador' do
    # Arrange
    User.create!(name: 'João', cpf: 62053621044, email: 'joao@leilaodogalpao.com.br', role: 1, password: 'password')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'joao@leilaodogalpao.com.br'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar no sistema'

    # Assert
    expect(page).to have_content 'Leilão do Galpão'
    within('nav') do
      expect(page).to have_content 'João - joao@leilaodogalpao.com.br (ADMIN)'
      expect(page).to have_button 'Sair'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
  end

  it 'e visualiza os detalhes de sua conta' do

    # Arrange
    User.create!(name: 'João', cpf: 62053621044, email: 'joao@leilaodogalpao.com.br', role: 1, password: 'password')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'joao@leilaodogalpao.com.br'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar no sistema'
    click_on 'João - joao@leilaodogalpao.com.br (ADMIN)'

    # Assert
    expect(page).to have_content 'Usuário: João'
    expect(page).to have_content 'ADMINISTRADOR'
    expect(page).to have_content 'E-mail: joao@leilaodogalpao.com.br'
    expect(page).to have_content 'CPF: 620.536.210-44'

  end


end
