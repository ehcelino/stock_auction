require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Verifica o email ao criar um administrador' do
    it 'e o email está correto' do
      # Arrange

      # Act
      user = User.create!(name: 'João', cpf: 62053621044, email: 'joao@leilaodogalpao.com.br', role: 1, password: 'password')

      # Assert
      expect(user.valid?).to eq true
    end

    it 'e o email é inválido' do
      # Arrange

      # Act
      user = User.new(name: 'João', cpf: 62053621044, email: 'joao@ig.com.br', role: 1, password: 'password')
      user.valid?

      # Assert
      expect(user.valid?).to eq false
      expect(user.errors.full_messages[0]).to eq "E-mail de administrador inválido"
    end

  end
end
