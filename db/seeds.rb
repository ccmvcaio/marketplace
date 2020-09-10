# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Users
user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
second_user = User.create!(email: 'ana.santos@estrela.com', password: '123456')
third_user = User.create!(email: 'lucas.silva@comptec.com', password: '123456')

#Profiles
profile = Profile.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                          birth_date: '02/12/1992', role: 'Dev',
                          department: 'Tecnologia', cpf: '541.268.930-24', user: user)
second_profile = Profile.create!(full_name: 'Ana Santos', social_name: 'Ana',
                                 birth_date: '01/11/1993', role: 'Vendedora',
                                 department: 'Comercial', cpf: '923.176.840-96',
                                 user: second_user)
third_profile = Profile.create!(full_name: 'Lucas Silva e Silva', social_name: 'Lucas',
                                birth_date: '11/02/1999', role: 'Contador',
                                department: 'Financeiro', cpf: '209.902.990-31',
                                user: third_user, enterprise: another_enterprise)
#Enterprises
enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                email: 'comercial@estrela.com', country: 'Brasil',
                                state: 'São Paulo', address: 'Rua Dois, 22')
another_enterprise = Enterprise.create!(name: 'Comp Tec', cnpj: '91.359.154/0001-20',
                                        email: 'contato@comptec.com',country: 'Brasil',
                                        state: 'São Paulo', address: 'Rua Quatro, 44')

#Products
pan = Product.create!(name: 'Panela', category: 'Cozinha', price: '50,00',
                      description: 'Panela pouco usada com pequenos arranhados',
                      profile: second_profile)
tire = Product.create!(name: 'Pneu', category: 'Carro', price: '250,00',
                       description: 'Pneu novo aro 15', profile: third_profile)
flip_flop = Product.create!(name: 'Chinelo', category: 'Vestuário', price: '20,00',
                            description: 'Chinelo do Dragon Ball', profile: second_profile)
                                
