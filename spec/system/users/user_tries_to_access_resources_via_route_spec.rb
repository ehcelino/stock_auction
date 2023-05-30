require 'rails_helper'

describe 'Usuário (não logado) tenta acessar recursos via rota' do
  it 'lista de lotes finalizados' do
    # Arrange

    # Act
    visit closed_list_auction_lots_path

    # Assert
    expect(page).to have_content 'É necessário estar logado.'
  end

  it 'página de informação do usuário' do
    # Arrange

    # Act
    visit user_path

    # Assert
    expect(page).to have_content 'É necessário estar logado.'
  end

end
