# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br',
            role: 1, password: 'password')
User.create!(name: 'Daniel', cpf: 92063172021, email: 'daniel@leilaodogalpao.com.br',
            role: 1, password: 'password')
User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br',
            role: 0, password: 'password')

Category.create!(name:'Geral')
Category.create!(name:'Informática')

item_1 = Item.create!(name:'Mouse Logitech', description:'Mouse Gamer 1200dpi', weight: 200,
                     width: 6, height: 3, depth: 11, category_id: 2)
item_2 = Item.create!(name:'Mouse Microsoft', description:'Mouse laser sem fio', weight: 200,
                     width: 6, height: 3, depth: 11, category_id: 2)
item_3 = Item.create!(name:'Thumb drive Sandisk', description:'Thumb drive USB3 32Gb', weight: 50,
                     width: 2, height: 1, depth: 5, category_id: 2)

item_1.image.attach(io: File.open(Rails.root.join("app/assets/images/mouse.jpg")), filename: "mouse.jpg")
item_2.image.attach(io: File.open(Rails.root.join("app/assets/images/msmouse.png")), filename: "msmouse.png")
item_3.image.attach(io: File.open(Rails.root.join("app/assets/images/tdrive.jpg")), filename: "tdrive.jpg")

auction_lot_1 = AuctionLot.create!(code:'XPG035410', start_date: '01/05/2023', end_date: '10/06/2023',
                                  min_bid_amount: 300, min_bid_difference: 50, status: 5, created_by: 1, approved_by: 2)
auction_lot_2 = AuctionLot.create!(code:'BGO570364', start_date: '20/06/2024', end_date: '10/07/2024',
                                  min_bid_amount: 500, min_bid_difference: 10, status: 0, created_by: 1)

LotItem.create!(auction_lot_id: auction_lot_1.id, item_id: item_1.id)
