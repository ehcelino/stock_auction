require 'rails_helper'

describe 'Admin entra no sistema' do
  it 'e vê lista de itens não associados com lotes' do
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

    # Assert
    expect(page).to have_css('img[src*="mouse.jpg"]')
    expect(page).to have_content 'Mouse Logitech'
    expect(page).to have_content 'Mouse Gamer 1200dpi'
    expect(page).to have_css('img[src*="msmouse.png"]')
    expect(page).to have_content 'Mouse Microsoft'
    expect(page).to have_content 'Mouse laser sem fio'
    expect(page).to have_css('img[src*="tdrive.jpg"]')
    expect(page).to have_content 'Thumb drive Sandisk 32GB'
    expect(page).to have_content 'Thumb drive USB3 32GB'

  end

  it 'e edita um item' do
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

end
