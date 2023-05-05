require 'rails_helper'

RSpec.describe Item, type: :model do

  describe '#valid?' do
    it 'Contém um código' do
      # Arrange
      category = Category.create!(name:'Informática')
      item = Item.new(name: 'Mouse Logitech', description: 'Mouse Gamer 1200dpi', weight: 200, width: 6, height: 3, depth: 11, category: category)
      # Act
      result = item.valid?

      # Assert
      expect(result).to be true
    end
  end

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

    it 'e o código é único' do
      # Arrange
      category = Category.create!(name:'Informática')
      first_item = Item.create!(name: 'Mouse Logitech', description: 'Mouse Gamer 1200dpi', weight: 200, width: 6, height: 3, depth: 11, category: category)
      second_item = Item.new(name:'Thumb drive Sandisk', description:'Thumb drive USB3 32Gb', weight: 50, width: 2, height: 1, depth: 5, category: category)

      # Act
      second_item.save!

      # Assert
      expect(second_item.code).not_to eq first_item.code
    end

  end

end
