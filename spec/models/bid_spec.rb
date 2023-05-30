require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

RSpec.describe Bid, type: :model do
  it 'Usuário tenta registrar um lance em um leilão que já venceu' do
    # Arrange
    admin_1 = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                          role: 1, password: 'password')
    admin_2 = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                          role: 1, password: 'password')
    travel_to(2.months.ago) do
    @auction_lot = AuctionLot.create!(code:'XPG035410', start_date: 1.day.from_now, end_date: 10.days.from_now,
                                    min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin_1, approver: admin_2)
    end
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @auction_lot.id, item_id: item.id)
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
    bid = Bid.new(auction_lot: @auction_lot, user: user, value: 320)

    # Act
    result = bid.valid?

    # Assert
    expect(result).to be false
    expect(bid.errors[:base]).to include 'Este leilão não pode receber novos lances'
    expect(bid.errors.count).to eq 1
  end

  it 'Usuário bloqueado tenta registrar um lance' do
    # Arrange
    admin_1 = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                          role: 1, password: 'password')
    admin_2 = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                          role: 1, password: 'password')
    travel_to(1.month.ago) do
    @auction_lot = AuctionLot.create!(code:'XPG035410', start_date: 1.day.from_now, end_date: 2.months.from_now,
                                    min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin_1, approver: admin_2)
    end
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @auction_lot.id, item_id: item.id)
    user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                        role: 0, password: 'password', status: 5)
    bid = Bid.new(auction_lot: @auction_lot, user: user, value: 320)

    # Act
    result = bid.valid?

    # Assert
    expect(result).to be false
    expect(bid.errors[:base]).to include 'Usuários bloqueados não podem fazer lances'
    expect(bid.errors.count).to eq 1
  end

  it 'administrador tenta registrar um lance' do
    # Arrange
    admin_1 = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
          role: 1, password: 'password')
    admin_2 = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
          role: 1, password: 'password')
    travel_to(1.month.ago) do
    @auction_lot = AuctionLot.create!(code:'XPG035410', start_date: 1.day.from_now, end_date: 2.months.from_now,
                    min_bid_amount: 300, min_bid_difference: 50, status: 5, creator: admin_1, approver: admin_2)
    end
    category = Category.create!(name:'Informática')
    item = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
        width: 6, height: 3, depth: 11, category_id: category.id)
    LotItem.create!(auction_lot_id: @auction_lot.id, item_id: item.id)

    # Act
    bid = Bid.new(auction_lot: @auction_lot, user: admin_1, value: 320)
    result = bid.valid?

    # Assert
    expect(result).to be false
    expect(bid.errors[:base]).to include 'Usuários administradores não podem fazer lances'
    expect(bid.errors.count).to eq 1
  end
end
