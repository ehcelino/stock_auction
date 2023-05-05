require 'rails_helper'

describe 'Administrador cria um novo item' do
  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'João', cpf: 62053621044, email: 'joao@leilaodogalpao.com.br', role: 1, password: 'password')
    Category.create!(name: 'Geral')
    Category.create!(name: 'Informática')
    # Act
    login_as user
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Cadastrar item'
    fill_in 'Nome', with: 'Mouse Logitech'
    fill_in 'Descrição', with: 'Mouse Gamer 1200dpi'
    fill_in 'Peso', with: '200'
    fill_in 'Largura', with: '6'
    fill_in 'Altura', with: '3'
    fill_in 'Profundidade', with: '11'
    select 'Informática', from: 'Categoria'
    click_on 'Cadastrar'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Item cadastrado com sucesso'

  end

  it 'e não preenche todos os campos' do
    # Arrange
    user = User.create!(name: 'João', cpf: 62053621044, email: 'joao@leilaodogalpao.com.br', role: 1, password: 'password')
    Category.create!(name: 'Geral')
    Category.create!(name: 'Informática')
    # Act
    login_as user
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Cadastrar item'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: 'Mouse Gamer 1200dpi'
    fill_in 'Peso', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Profundidade', with: ''
    select 'Informática', from: 'Categoria'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Não foi possível cadastrar o item'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Peso não pode ficar em branco'
    expect(page).to have_content 'Largura não pode ficar em branco'
    expect(page).to have_content 'Altura não pode ficar em branco'
    expect(page).to have_content 'Profundidade não pode ficar em branco'

  end

end
