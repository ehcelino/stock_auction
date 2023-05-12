require 'rails_helper'

RSpec.describe BlockedCpf, type: :model do
  describe '#valid?' do
    it 'CPF inválido' do
      # Arrange
      blocked_cpf = BlockedCpf.new(cpf: 2304321223)

      # Act
      result = blocked_cpf.valid?

      # Assert
      expect(result).to be false
      expect(blocked_cpf.errors[:cpf]).to include 'inválido'
    end

    it 'CPF em uso' do
      # Arrange
      BlockedCpf.create!(cpf: 37378120049)
      blocked_cpf = BlockedCpf.new(cpf: 37378120049)

      # Act
      result = blocked_cpf.valid?

      # Assert
      expect(result).to be false
      expect(blocked_cpf.errors[:cpf]).to include 'já está em uso'
    end

    it 'CPF em branco' do
      # Arrange
      blocked_cpf = BlockedCpf.new()

      # Act
      result = blocked_cpf.valid?

      # Assert
      expect(result).to be false
      expect(blocked_cpf.errors[:cpf]).to include 'não pode ficar em branco'
    end
  end
end
