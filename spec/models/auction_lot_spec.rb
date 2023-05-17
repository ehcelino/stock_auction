require 'rails_helper'

RSpec.describe AuctionLot, type: :model do

  describe '#valid?' do
    it 'deve ter um código válido' do
      # Arrange
      admin_1 = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                            role: 1, password: 'password')
      admin_2 = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                            role: 1, password: 'password')
      auction_lot = AuctionLot.new(code:'035410XPG', start_date: 1.day.from_now, end_date: 10.days.from_now,
                                  min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin_1, approver: admin_2)

      # Act
      result = auction_lot.valid?

      #Assert
      expect(result).to be false
      expect(auction_lot.errors[:code]).to include 'inválido. O formato é XXX000000'
      expect(auction_lot.errors.count).to eq 1
    end

    it 'deve ter uma data final válida' do
      # Arrange
      admin_1 = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                            role: 1, password: 'password')
      admin_2 = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                            role: 1, password: 'password')
      auction_lot = AuctionLot.new(code:'XPG035410', start_date: 10.days.from_now, end_date: 8.days.from_now,
                                  min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin_1, approver: admin_2)

      # Act
      auction_lot.valid?
      result = auction_lot.errors.include?(:end_date)

      #Assert
      expect(result).to be true
      expect(auction_lot.errors[:end_date]).to include 'deve ser maior que a data de início'
      expect(auction_lot.errors.count).to eq 1
    end

    it 'deve ser aprovado por um usuário diferente' do
      # Arrange
      admin_1 = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                            role: 1, password: 'password')
      auction_lot = AuctionLot.new(code:'XPG035410', start_date: 10.days.from_now, end_date: 30.days.from_now,
                                  min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin_1, approver: admin_1)

      # Act
      result = auction_lot.valid?

      #Assert
      expect(result).to be false
      expect(auction_lot.errors[:base]).to include 'Um lote não pode ser aprovado pelo usuário que o criou'
      expect(auction_lot.errors.count).to eq 1

    end

    it 'deve ser criado por um administrador' do
      # Arrange
      user = User.create!(name: 'John', cpf: 31887493093, email: 'john@ig.com.br',
                            role: 0, password: 'password')
      admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                            role: 1, password: 'password')
      auction_lot = AuctionLot.new(code:'XPG035410', start_date: 1.day.from_now, end_date: 1.month.from_now,
                                  min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: user, approver: admin)

      # Act
      auction_lot.valid?
      result = auction_lot.errors.include?(:base)

      #Assert
      expect(result).to be true
      expect(auction_lot.errors[:base]).to include 'Para manipular um lote o usuário deve ser administrador'
      expect(auction_lot.errors.count).to eq 1
    end

    it 'deve ser aprovado por um administrador' do
      # Arrange
      user = User.create!(name: 'John', cpf: 31887493093, email: 'john@ig.com.br',
                            role: 0, password: 'password')
      admin = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                            role: 1, password: 'password')
      auction_lot = AuctionLot.new(code:'XPG035410', start_date: 1.day.from_now, end_date: 1.month.from_now,
                                  min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin, approver: user)

      # Act
      auction_lot.valid?
      result = auction_lot.errors.include?(:base)

      #Assert
      expect(result).to be true
      expect(auction_lot.errors[:base]).to include 'Para manipular um lote o usuário deve ser administrador'
      expect(auction_lot.errors.count).to eq 1
    end

  end

end
