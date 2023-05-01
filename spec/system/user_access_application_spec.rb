require 'rails_helper'

describe 'Usuário acessa o sistema' do
  it 'e vê a tela inicial' do
    # Arrange

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Leilão do Galpão'
    within('nav') do
      expect(page).to have_link 'Entrar'
    end

  end

end
