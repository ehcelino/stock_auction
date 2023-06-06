require 'rails_helper'

describe 'Administrador loga na aplicação' do
  it 'e vê uma lista de usuários cadastrados' do
    # Arrange
    admin = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                        role: 1, password: 'password')
    second_admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                                role: 1, password: 'password')
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    second_user = User.create!(name: 'Ian', cpf: 34378847000, email: 'ian@ig.com.br',
                               role: 0, password: 'password')

    # Act
    login_as admin
    visit root_path
    click_on 'Funções administrativas'
    click_on 'Gerenciar usuários'

    # Assert
    expect(page).to have_content 'Usuários cadastrados'
    expect(page).to have_content 'Daniel'
    expect(page).to have_content '920.631.720-21'
    expect(page).to have_content 'daniel@leilaodogalpao.com.br'
    expect(page).to have_content 'Michael'
    expect(page).to have_content '620.595.760-40'
    expect(page).to have_content 'michael@ig.com.br'

  end
end
