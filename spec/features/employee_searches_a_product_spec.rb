feature 'Employee searches a product' do
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
    product = Product.create!(name: 'Panela', category: 'Cozinha', price: '50,00',
                              description: 'Panela pouco usada com pequenos arranhados',
                              profile: second_profile)
    second_product = Product.create!(name: 'Chinelo', category: 'Vestuário', price: '20,00',
                                     description: 'Chinelo do Dragon Ball',
                                     profile: second_profile)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Produtos'
    fill_in 'Buscar produto', with: 'Panela'
    click_on 'Buscar'

    expect(page).to have_content('Panela - R$ 50,00')
    expect(page).to_not have_content('Chinelo - R$ 20,00')
  end

  scenario 'and searches by category' do
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
    product = Product.create!(name: 'Panela', category: 'Cozinha', price: '50,00',
                              description: 'Panela pouco usada com pequenos arranhados',
                              profile: second_profile)
    second_product = Product.create!(name: 'Copo do Batman', category: 'Cozinha', price: '20,00',
                                     description: 'Copo personalizado do batman 500ml',
                                     profile: second_profile)
    third_product = Product.create!(name: 'Lupa', category: 'Utensílios', price: '10,00',
                                    description: 'Lupa portátil', profile: second_profile)
  
    login_as(user, scope: :user)
    visit root_path
    click_on 'Produtos'
    fill_in 'Buscar produto', with: 'cozinha'
    click_on 'Buscar'

    expect(page).to have_content('Panela - R$ 50,00')
    expect(page).to have_content('Copo do Batman - R$ 20,00')
    expect(page).to_not have_content('Lupa - R$ 10,00')
  end

  scenario 'and finds by description' do
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
    product = Product.create!(name: 'Panela', category: 'Cozinha', price: '50,00',
                              description: 'Panela pouco usada com pequenos arranhados',
                              profile: second_profile)
    second_product = Product.create!(name: 'Copo do Batman', category: 'Cozinha', price: '20,00',
                                     description: 'Copo personalizado do batman 500ml',
                                     profile: second_profile)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Produtos'
    fill_in 'Buscar produto', with: '500ml'
    click_on 'Buscar'

    expect(page).to have_content('Copo do Batman - R$ 20,00')
    expect(page).to_not have_content('Panela - R$ 50,00')
  end

  scenario 'and finds no product' do
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
    product = Product.create!(name: 'Panela', category: 'Cozinha', price: '50,00',
                              description: 'Panela pouco usada com pequenos arranhados',
                              profile: second_profile)
    second_product = Product.create!(name: 'Copo do Batman', category: 'Cozinha', price: '20,00',
                                     description: 'Copo personalizado do batman 500ml',
                                     profile: second_profile)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Produtos'
    fill_in 'Buscar produto', with: 'chinelo'
    click_on 'Buscar'

    expect(page).to have_content('Nenhum produto encontrado!')
    expect(page).to_not have_content('Panela - R$ 50,00')
    expect(page).to_not have_content('Copo do Batman - R$ 20,00')
  end
end