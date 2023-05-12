require 'rails_helper'

describe 'Admin cadastra um novo CPF' do
  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                        role: 1, password: 'password')
    # Act
    login_as user
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Bloqueio de CPF'
    click_on 'Adicionar CPF à lista de bloqueio'
    fill_in 'CPF', with: '37378120049'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'CPF adicionado à lista de bloqueio'
    expect(page).to have_content '373.781.200-49'
  end

  it 'com CPF inválido' do
    # Arrange
    user = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                        role: 1, password: 'password')
    # Act
    login_as user
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Bloqueio de CPF'
    click_on 'Adicionar CPF à lista de bloqueio'
    fill_in 'CPF', with: '37373120049'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Ocorreu um erro'
    expect(page).to have_content 'CPF inválido.'
  end

  it 'com CPF em branco' do
    # Arrange
    user = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                        role: 1, password: 'password')
    # Act
    login_as user
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Bloqueio de CPF'
    click_on 'Adicionar CPF à lista de bloqueio'
    fill_in 'CPF', with: ''
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Ocorreu um erro'
    expect(page).to have_content 'CPF não pode ficar em branco.'
  end
end
