# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
admin_1 = User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
                      role: 1, password: 'password')
admin_2 = User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
                      role: 1, password: 'password')
user = User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
                   role: 0, password: 'password')
user = User.create!(name: 'Fernando', cpf: 12920704044, email: 'fernando@ig.com.br',
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

auction_lot_1 = AuctionLot.create!(code:'XPG035410', start_date: '01/05/2023', end_date: 1.month.from_now,
                                  min_bid_amount: 100, min_bid_difference: 2, status: 5, created_by: admin_1.id, approved_by: admin_2.id)
auction_lot_2 = AuctionLot.create!(code:'BGO570364', start_date: 2.months.from_now, end_date: 3.months.from_now,
                                  min_bid_amount: 500, min_bid_difference: 10, status: 0, created_by: admin_1.id)
auction_lot_3 = AuctionLot.create!(code:'PGA359841', start_date: '01/04/2023', end_date: '20/04/2023',
                                  min_bid_amount: 100, min_bid_difference: 10, status: 5, created_by: admin_1.id, approved_by: admin_2.id)
auction_lot_4 = AuctionLot.create!(code:'JKY174683', start_date: '01/03/2023', end_date: '20/03/2023',
                                  min_bid_amount: 100, min_bid_difference: 10, status: 5, created_by: admin_1.id, approved_by: admin_2.id)
auction_lot_5 = AuctionLot.create!(code:'CVZ574198', start_date: 10.days.from_now, end_date: 1.month.from_now,
                                  min_bid_amount: 100, min_bid_difference: 10, status: 5, created_by: admin_1.id, approved_by: admin_2.id)
auction_lot_6 = AuctionLot.create!(code:'LHD753159', start_date: '01/02/2023', end_date: '20/02/2023',
                                  min_bid_amount: 100, min_bid_difference: 10, status: 5, created_by: admin_1.id, approved_by: admin_2.id)

LotItem.create!(auction_lot_id: auction_lot_1.id, item_id: item_1.id)
LotItem.create!(auction_lot_id: auction_lot_3.id, item_id: item_2.id)
LotItem.create!(auction_lot_id: auction_lot_4.id, item_id: item_3.id)
LotItem.create!(auction_lot_id: auction_lot_5.id, item_id: item_4.id)
LotItem.create!(auction_lot_id: auction_lot_6.id, item_id: item_6.id)


Bid.create!(auction_lot_id: auction_lot_3.id, user_id: user.id, value: 101)
Bid.create!(auction_lot_id: auction_lot_6.id, user_id: user.id, value: 101)

auction_lot_6.closed!

Qna.create!(auction_lot_id: auction_lot_1.id, question: 'Este lote será entregue em minha residência?',
            answer: 'Não, ele deve ser retirado na empresa.', user_id: admin_1.id)
