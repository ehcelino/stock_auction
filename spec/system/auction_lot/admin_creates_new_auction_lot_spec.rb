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
    fill_in 'Data de início', with: '20/05/2023'
    fill_in 'Data de término', with: '30/05/2023'
    fill_in 'Lance inicial', with: 100
    fill_in 'Diferença entre lances', with: 50
    click_on 'Criar lote'

    # Assert
    expect(page).to have_content 'Lote criado com sucesso'
    # expect(page).to have_content

  end

end
