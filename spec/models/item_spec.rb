require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Gera um código' do
    it 'ao criar um item' do
      # Arrange
      category = Category.create!(name:'Informática')

      # Act
      item = Item.create!(name: 'Mouse Logitech', description: 'Mouse Gamer 1200dpi', weight: 200, width: 6, height: 3, depth: 11, category: category)

      # Assert
      expect(item.code.length).to eq(10)
    end

    it 'e o código se mantém após update' do
      # Arrange
      category = Category.create!(name:'Informática')
      item = Item.create!(name: 'Mouse Logitech', description: 'Mouse Gamer 1200dpi', weight: 200, width: 6, height: 3, depth: 11, category: category)
      original_code = item.code
      # Act
      item.update!(name: 'Mouse Logitech Razor')

      # Assert
      expect(item.code).to eq original_code
      expect(item.name).to eq 'Mouse Logitech Razor'
    end

  end

end
