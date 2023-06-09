require 'rails_helper'

describe 'Administrador cria um novo item' do
  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'João', cpf: 62053621044, email: 'joao@leilaodogalpao.com.br', role: 1, password: 'password')
    Category.create!(name: 'Geral')
    Category.create!(name: 'Informática')
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABC1234567')

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
    attach_file 'Imagem', "#{Rails.root}/app/assets/images/mouse.jpg"
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Item cadastrado com sucesso'
    expect(page).to have_css('img[src*="mouse.jpg"]')
    expect(page).to have_content 'Mouse Logitech'
    expect(page).to have_content 'Mouse Gamer 1200dpi'
    expect(page).to have_content '200 g.'
    expect(page).to have_content '6 x 3 x 11 cm'
    expect(page).to have_content 'ABC1234567'
    expect(page).to have_content 'Informática'

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
