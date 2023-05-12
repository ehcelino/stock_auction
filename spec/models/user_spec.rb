require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Verifica o email ao criar um administrador' do
    it 'e o email está correto' do
      # Arrange

      # Act
      user = User.new(name: 'João', cpf: 62053621044, email: 'joao@leilaodogalpao.com.br', role: 1, password: 'password')

      # Assert
      expect(user.valid?).to eq true
    end

  end
end
