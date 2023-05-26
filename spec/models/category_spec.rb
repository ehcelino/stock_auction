require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#valid?' do
    it 'duplicado' do
      # Arrange
      Category.create!(name:'Informática')

      # Act
      category = Category.new(name:'Informática')
      result = category.valid?

      # Assert
      expect(result).to eq false
      expect(category.errors[:name]).to include 'já está em uso'
    end

    it 'campos vazios' do
      # Arrange

      # Act
      category = Category.new(name:'')
      result = category.valid?

      # Assert
      expect(result).to eq false
      expect(category.errors[:name]).to include 'não pode ficar em branco'
    end
  end
end
