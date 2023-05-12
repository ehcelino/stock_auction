require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context 'presença' do
      it 'falso com nome vazio' do
        # Arrange
        user = User.new(name: '', cpf: 62053621044, email: 'joao@leilaodogalpao.com.br', password: 'password')

        # Act
        result = user.valid?

        # Assert
        expect(result).to eq false
      end

      it 'falso com CPF vazio' do
        # Arrange
        user = User.new(name: 'João', email: 'joao@leilaodogalpao.com.br', password: 'password')

        # Act
        result = user.valid?

        # Assert
        expect(result).to eq false
      end

      it 'falso com email vazio' do
        # Arrange
        user = User.new(name: 'João', cpf: 62053621044, email: '', password: 'password')

        # Act
        result = user.valid?

        # Assert
        expect(result).to eq false
      end

    end

    it 'todos os campos corretos' do
      # Arrange
      user = User.new(name: 'João', cpf: 62053621044, email: 'joao@leilaodogalpao.com.br', password: 'password')

      # Act
      result = user.valid?

      # Assert
      expect(result).to eq true
    end

    it 'com CPF inválido' do
      # Arrange
      user = User.new(name: 'João', cpf: 62052621044, email: 'joao@leilaodogalpao.com.br', password: 'password')

      # Act
      result = user.valid?

      # Assert
      expect(result).to eq false
      expect(user.errors[:cpf]).to include 'inválido'
    end

  end
end
