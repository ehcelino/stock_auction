require 'rails_helper'

describe 'Admin cria nova categoria' do
  it 'com sucesso' do
    # Arrange
    admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                        role: 1, password: 'password')

    # Act
    login_as admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Categorias'
    click_on 'Nova categoria'
    fill_in 'Nome', with: 'Gadgets'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Categoria criada com sucesso'
    expect(page).to have_content 'Gadgets'
  end

  it 'e não preenche o campo' do
    # Arrange
    admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                        role: 1, password: 'password')

    # Act
    login_as admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Categorias'
    click_on 'Nova categoria'
    fill_in 'Nome', with: ''
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Houve um erro na criação da categoria'
    expect(page).to have_content 'Nome não pode ficar em branco'
  end

  it 'e usa um nome duplicado' do
    # Arrange
    admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                        role: 1, password: 'password')
    Category.create!(name:'Gadgets')

    # Act
    login_as admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Categorias'
    click_on 'Nova categoria'
    fill_in 'Nome', with: 'Gadgets'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Houve um erro na criação da categoria'
    expect(page).to have_content 'Nome já está em uso'
  end

end
