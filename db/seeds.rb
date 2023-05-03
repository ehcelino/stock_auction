# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(name: 'John', cpf: 31887493093, email: 'john@leilaodogalpao.com.br', role: 1, password: 'password')
User.create!(name: 'Michael', cpf: 62059576040, email: 'michael@ig.com.br', role: 0, password: 'password')

Category.create!(name:'Geral')
Category.create!(name:'Informática')
