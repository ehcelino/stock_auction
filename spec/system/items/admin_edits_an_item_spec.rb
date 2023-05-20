require 'rails_helper'

describe 'Administrador edita um item' do
  it 'com sucesso' do
    # Arrange
    admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                        role: 1, password: 'password')
    category = Category.create!(name:'Informática')
    first_item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                              width: 6, height: 3, depth: 11, category_id: category.id)
    second_item = Item.create!(name:'Mouse Microsoft', description:'Mouse laser sem fio', weight: 200,
                              width: 6, height: 3, depth: 11, category_id: category.id)
    third_item = Item.create!(name:'Thumb drive Sandisk 32GB', description:'Thumb drive USB3 32GB', weight: 50,
                              width: 2, height: 1, depth: 5, category_id: category.id)
    first_item.image.attach(io: File.open(Rails.root.join("app/assets/images/mouse.jpg")), filename: "mouse.jpg")
    second_item.image.attach(io: File.open(Rails.root.join("app/assets/images/msmouse.png")), filename: "msmouse.png")
    third_item.image.attach(io: File.open(Rails.root.join("app/assets/images/tdrive.jpg")), filename: "tdrive.jpg")

    # Act
    login_as admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Itens avulsos'
    find('#edit-item_1').click
    fill_in 'Nome', with: 'Mouse Logitech Max'
    fill_in 'Descrição', with: 'Mouse Gamer 6 botões macro'
    click_on 'Salvar alterações'

    # Assert
    expect(page).to have_content 'Item atualizado com sucesso'
    expect(page).to have_content 'Item para leilão: Mouse Logitech Max'
    expect(page).to have_content 'Mouse Gamer 6 botões macro'

  end

  it 'com erro' do
    # Arrange
    admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                        role: 1, password: 'password')
    category = Category.create!(name:'Informática')
    first_item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                              width: 6, height: 3, depth: 11, category_id: category.id)
    second_item = Item.create!(name:'Mouse Microsoft', description:'Mouse laser sem fio', weight: 200,
                              width: 6, height: 3, depth: 11, category_id: category.id)
    third_item = Item.create!(name:'Thumb drive Sandisk 32GB', description:'Thumb drive USB3 32GB', weight: 50,
                              width: 2, height: 1, depth: 5, category_id: category.id)
    first_item.image.attach(io: File.open(Rails.root.join("app/assets/images/mouse.jpg")), filename: "mouse.jpg")
    second_item.image.attach(io: File.open(Rails.root.join("app/assets/images/msmouse.png")), filename: "msmouse.png")
    third_item.image.attach(io: File.open(Rails.root.join("app/assets/images/tdrive.jpg")), filename: "tdrive.jpg")

    # Act
    login_as admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Itens avulsos'
    find('#edit-item_1').click
    fill_in 'Nome', with: 'Mouse Logitech Max'
    fill_in 'Descrição', with: 'Mouse Gamer 6 botões macro'
    fill_in 'Largura', with: '-1'
    click_on 'Salvar alterações'

    # Assert
    expect(page).to have_content 'Falha na atualização'
    expect(page).to have_content 'Largura deve ser maior que 0.'

  end

end
