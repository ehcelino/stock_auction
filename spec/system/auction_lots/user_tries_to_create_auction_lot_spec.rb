require 'rails_helper'

describe 'usuário acessa o sistema' do
  it 'e tenta criar um lote para leilão' do
    # Arrange
    user = User.create!(name: 'George', cpf: 62059576040, email: 'george@ig.com.br',
                        role: 0, password: 'password')

    # Act
    login_as user
    visit new_auction_lot_path

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar este recurso'
  end
end
