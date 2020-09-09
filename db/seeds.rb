# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
profile = Profile.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                          birth_date: '02/12/1992', role: 'Dev',
                          department: 'Tecnologia', cpf: '541.268.930-24', user: user)
enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                email: 'comercial@estrela.com', country: 'Brasil',
                                state: 'São Paulo', address: 'Rua Dois, 22')
                                
