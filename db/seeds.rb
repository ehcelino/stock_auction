# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
admin_1 = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                      role: 1, password: 'password')
admin_2 = User.create!(name: 'Paul', cpf: 92063172021, email: 'paul@leilaodogalpao.com.br',
                      role: 1, password: 'password')
user = User.create!(name: 'George', cpf: 62059576040, email: 'george@ig.com.br',
                   role: 0, password: 'password')
user_2 = User.create!(name: 'Ringo', cpf: 12920704044, email: 'ringo@ig.com.br',
                      role: 0, password: 'password')
user_3 = User.create!(name: 'Pete', cpf: 59487334084, email: 'pete@ig.com.br',
                      role: 0, password: 'password')
user_4 = User.create!(name: 'Michael', cpf: 88283189026, email: 'michael@ig.com.br',
                        role: 0, password: 'password')
user_5 = User.create!(name: 'Alexander', cpf: 97489383013, email: 'alex@ig.com.br',
                      role: 0, password: 'password')


BlockedCpf.create!(cpf: 12920704044)

Category.create!(name:'Geral')
Category.create!(name:'Informática')

item_1 = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                      width: 6, height: 3, depth: 11, category_id: 2)
item_2 = Item.create!(name:'Mouse Microsoft', description:'Mouse laser sem fio', weight: 200,
                      width: 6, height: 3, depth: 11, category_id: 2)
item_3 = Item.create!(name:'Thumb drive Sandisk 32GB', description:'Thumb drive USB3 32GB', weight: 50,
                      width: 2, height: 1, depth: 5, category_id: 2)
item_4 = Item.create!(name:'Thumb drive Sandisk 64GB', description:'Thumb drive USB3 64GB', weight: 50,
                      width: 2, height: 1, depth: 5, category_id: 2)
item_5 = Item.create!(name:'Thumb drive Sandisk 128GB', description:'Thumb drive USB3 128GB', weight: 50,
                      width: 2, height: 1, depth: 5, category_id: 2)
item_6 = Item.create!(name:'Thumb drive Sandisk 256GB', description:'Thumb drive USB3 256GB', weight: 50,
                      width: 2, height: 1, depth: 5, category_id: 2)

item_1.image.attach(io: File.open(Rails.root.join("app/assets/images/mouse.jpg")), filename: "mouse.jpg")
item_2.image.attach(io: File.open(Rails.root.join("app/assets/images/msmouse.png")), filename: "msmouse.png")
item_3.image.attach(io: File.open(Rails.root.join("app/assets/images/tdrive.jpg")), filename: "tdrive.jpg")
item_4.image.attach(io: File.open(Rails.root.join("app/assets/images/tdrive.jpg")), filename: "tdrive.jpg")
item_5.image.attach(io: File.open(Rails.root.join("app/assets/images/tdrive.jpg")), filename: "tdrive.jpg")
item_6.image.attach(io: File.open(Rails.root.join("app/assets/images/tdrive.jpg")), filename: "tdrive.jpg")

auction_lot_1 = AuctionLot.new(code:'XPG035410', start_date: '01/05/2023', end_date: 1.month.from_now,
                                  min_bid_amount: 100, min_bid_difference: 2, status: 5, creator: admin_1, approver: admin_2)
auction_lot_1.save!(validate: false)
auction_lot_2 = AuctionLot.create!(code:'BGO570364', start_date: 2.months.from_now, end_date: 3.months.from_now,
                                  min_bid_amount: 500, min_bid_difference: 10, status: 0, creator: admin_1)
auction_lot_3 = AuctionLot.new(code:'PGA359841', start_date: '01/04/2023', end_date: '20/04/2023',
                                  min_bid_amount: 100, min_bid_difference: 10, status: 5, creator: admin_1, approver: admin_2)
auction_lot_3.save!(validate: false)
auction_lot_4 = AuctionLot.new(code:'JKY174683', start_date: '01/03/2023', end_date: '20/03/2023',
                                  min_bid_amount: 100, min_bid_difference: 10, status: 5, creator: admin_1, approver: admin_2)
auction_lot_4.save!(validate: false)
auction_lot_5 = AuctionLot.create!(code:'CVZ574198', start_date: 10.days.from_now, end_date: 1.month.from_now,
                                  min_bid_amount: 100, min_bid_difference: 10, status: 5, creator: admin_1, approver: admin_2)
auction_lot_6 = AuctionLot.new(code:'LHD753159', start_date: '01/02/2023', end_date: '20/02/2023',
                                  min_bid_amount: 100, min_bid_difference: 10, status: 5, creator: admin_1, approver: admin_2)
auction_lot_6.save!(validate: false)
auction_lot_7 = AuctionLot.new(code:'DNB326710', start_date: '01/05/2023', end_date: 1.month.from_now,
                              min_bid_amount: 100, min_bid_difference: 10, status: 5, creator: admin_1, approver: admin_2)
auction_lot_7.save!(validate: false)

LotItem.create!(auction_lot_id: auction_lot_1.id, item_id: item_1.id)
LotItem.create!(auction_lot_id: auction_lot_3.id, item_id: item_2.id)
LotItem.create!(auction_lot_id: auction_lot_4.id, item_id: item_3.id)
LotItem.create!(auction_lot_id: auction_lot_5.id, item_id: item_4.id)
LotItem.create!(auction_lot_id: auction_lot_6.id, item_id: item_6.id)
LotItem.create!(auction_lot_id: auction_lot_7.id, item_id: item_5.id)


bid_1 = Bid.new(auction_lot_id: auction_lot_3.id, user_id: user.id, value: 101)
bid_1.save!(validate: false)
bid_2 = Bid.new(auction_lot_id: auction_lot_6.id, user_id: user.id, value: 101)
bid_2.save!(validate: false)
bid_3 = Bid.new(auction_lot_id: auction_lot_3.id, user_id: user_3.id, value: 150)
bid_3.save!(validate: false)
bid_4 = Bid.new(auction_lot_id: auction_lot_1.id, user_id: user_3.id, value: 150)
bid_4.save!(validate: false)
bid_5 = Bid.new(auction_lot_id: auction_lot_6.id, user_id: user_4.id, value: 150)
bid_5.save!(validate: false)
bid_6 = Bid.new(auction_lot_id: auction_lot_6.id, user_id: user.id, value: 200)
bid_6.save!(validate: false)
bid_7 = Bid.new(auction_lot_id: auction_lot_6.id, user_id: user_5.id, value: 250)
bid_7.save!(validate: false)
bid_8 = Bid.new(auction_lot_id: auction_lot_3.id, user_id: user_4.id, value: 250)
bid_8.save!(validate: false)


auction_lot_6.closed!

Qna.create!(auction_lot_id: auction_lot_1.id, question: 'Este lote será entregue em minha residência?',
            answer: 'Não, ele deve ser retirado na empresa.', user_id: admin_1.id)
Qna.create!(auction_lot_id: auction_lot_5.id, question: 'Quanto tempo eu tenho para retirar os produtos?',
              answer: 'Até 30 dias do final do leilão.', user_id: admin_2.id)
