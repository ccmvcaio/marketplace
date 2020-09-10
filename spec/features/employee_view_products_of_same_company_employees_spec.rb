feature 'employee view products of same company employees' do
  scenario 'successfully' do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22')
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
    profile = Profile.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                              birth_date: '02/12/1992', role: 'Dev',
                              department: 'Tecnologia', cpf: '541.268.930-24', user: user,
                              enterprise: enterprise)
    second_user = User.create!(email: 'ana.santos@estrela.com', password:'123456')
    second_profile = Profile.create!(full_name: 'Ana Santos', social_name: 'Ana',
                                     birth_date: '01/11/1993', role: 'Vendedora',
                                     department: 'Comercial', cpf: '923.176.840-96',
                                     user: second_user, enterprise: enterprise)
    third_user = User.create!(email: 'lucas.silva@estrela.com', password: '123456')
    third_profile = Profile.create!(full_name: 'Lucas Silva e Silva', social_name: 'Lucas',
                                 birth_date: '11/02/1999', role: 'Contador',
                                 department: 'Financeiro', cpf: '209.902.990-31',
                                 user: third_user, enterprise: enterprise)
    tire = Product.create!(name: 'Pneu', category: 'Carro', price: '250,00',
                           description: 'Pneu novo aro 15', profile: third_profile)
    flip_flop = Product.create!(name: 'Chinelo', category: 'Vestuário', price: '20,00',
                                description: 'Chinelo do Dragon Ball', profile: second_profile)
    pan = Product.create!(name: 'Panela', category: 'Cozinha', price: '50,00',
                          description: 'Panela pouco usada com pequenos arranhados',
                          profile: second_profile)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content('Panela - R$ 50,00')
    expect(page).to have_content('Pneu - R$ 250,00')
    expect(page).to have_content('Chinelo - R$ 20,00')
  end

  scenario 'and must be loged in' do
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content('Para continuar, faça login ou registre-se.')
    expect(current_path).to eq new_user_session_path 
  end

  scenario 'and not of other company' do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22')
    enterprise_comptec = Enterprise.create!(name: 'Comp Tec', cnpj: '91.359.154/0001-20',
                                            email: 'contato@comptec.com',country: 'Brasil',
                                            state: 'São Paulo', address: 'Rua Quatro, 44')
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
    profile = Profile.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                              birth_date: '02/12/1992', role: 'Dev',
                              department: 'Tecnologia', cpf: '541.268.930-24', user: user,
                              enterprise: enterprise)
    second_user = User.create!(email: 'ana.santos@estrela.com', password:'123456')
    second_profile = Profile.create!(full_name: 'Ana Santos', social_name: 'Ana',
                                    birth_date: '01/11/1993', role: 'Vendedora',
                                    department: 'Comercial', cpf: '923.176.840-96',
                                    user: second_user, enterprise: enterprise)
    user_comptec = User.create!(email: 'lucas.silva@comptec.com', password: '123456')
    profile_comptec = Profile.create!(full_name: 'Lucas Silva e Silva', social_name: 'Lucas',
                                    birth_date: '11/02/1999', role: 'Contador',
                                    department: 'Financeiro', cpf: '209.902.990-31',
                                    user: user_comptec, enterprise: enterprise_comptec)
    flip_flop = Product.create!(name: 'Chinelo', category: 'Vestuário', price: '20,00',
                                description: 'Chinelo do Dragon Ball', profile: second_profile)
    pan = Product.create!(name: 'Panela', category: 'Cozinha', price: '50,00',
                          description: 'Panela pouco usada com pequenos arranhados',
                          profile: second_profile)
    tire = Product.create!(name: 'Pneu', category: 'Carro', price: '250,00',
                           description: 'Pneu novo aro 15', profile: profile_comptec)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content('Panela - R$ 50,00')
    expect(page).to have_content('Chinelo - R$ 20,00')
    expect(page).to_not have_content('Pneu - R$ 250,00')
  end

  scenario 'and there are no products announced' do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22')
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
    profile = Profile.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                              birth_date: '02/12/1992', role: 'Dev',
                              department: 'Tecnologia', cpf: '541.268.930-24', user: user,
                              enterprise: enterprise)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content('Nenhum produto anunciado!')
  end

  scenario 'and there are no products announced from own company' do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22')
    enterprise_comptec = Enterprise.create!(name: 'Comp Tec', cnpj: '91.359.154/0001-20',
                                            email: 'contato@comptec.com',country: 'Brasil',
                                            state: 'São Paulo', address: 'Rua Quatro, 44')
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
    profile = Profile.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                              birth_date: '02/12/1992', role: 'Dev',
                              department: 'Tecnologia', cpf: '541.268.930-24', user: user,
                              enterprise: enterprise)
    user_comptec = User.create!(email: 'lucas.silva@comptec.com', password: '123456')
    profile_comptec = Profile.create!(full_name: 'Lucas Silva e Silva', social_name: 'Lucas',
                                    birth_date: '11/02/1999', role: 'Contador',
                                    department: 'Financeiro', cpf: '209.902.990-31',
                                    user: user_comptec, enterprise: enterprise_comptec)
    tire = Product.create!(name: 'Pneu', category: 'Carro', price: '250,00',
                           description: 'Pneu novo aro 15', profile: profile_comptec)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Produtos'

    expect(page).to_not have_content('Pneu - R$ 250,00')
    expect(page).to have_content('Nenhum produto anunciado!')
  end

  scenario 'and come back to hame page' do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22')
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
    profile = Profile.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                              birth_date: '02/12/1992', role: 'Dev',
                              department: 'Tecnologia', cpf: '541.268.930-24', user: user,
                              enterprise: enterprise)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Produtos'
    click_on 'Voltar'
    
    expect(page).to have_content('Market Place')
    expect(current_path).to eq root_path
  end
end