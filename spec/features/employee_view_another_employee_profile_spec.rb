feature 'Employee view another employee profile' do
  scenario 'successfully' do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                      state: 'São Paulo', address: 'Rua Dois, 22')
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
    second_user = User.create!(email: 'ana.santos@estrela.com', password: '123456')
    profile = Profile.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                              birth_date: '02/12/1992', role: 'Dev', enterprise: enterprise,
                              department: 'Tecnologia', cpf: '541.268.930-24', user: user)
    second_profile = Profile.create!(full_name: 'Ana Santos', social_name: 'Ana',
                                     birth_date: '01/11/1993', role: 'Vendedora',
                                     department: 'Comercial', cpf: '923.176.840-96',
                                     user: second_user, enterprise: enterprise)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Perfis'
    click_on 'Ana - Comercial'

    expect(page).to have_content('Ana Santos')
    expect(page).to have_content('Comercial')
    expect(page).to have_content('Vendedora')
    expect(page).to have_content('ana.santos@estrela.com')
  end

  scenario 'from profiles page' do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                      state: 'São Paulo', address: 'Rua Dois, 22')
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
    second_user = User.create!(email: 'ana.santos@estrela.com', password: '123456')
    profile = Profile.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                              birth_date: '02/12/1992', role: 'Dev', enterprise: enterprise,
                              department: 'Tecnologia', cpf: '541.268.930-24', user: user)
    second_profile = Profile.create!(full_name: 'Ana Santos', social_name: 'Ana',
                                     birth_date: '01/11/1993', role: 'Vendedora',
                                     department: 'Comercial', cpf: '923.176.840-96',
                                     user: second_user, enterprise: enterprise)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Perfis'

    expect(page).to have_content('Ana - Comercial')
  end

  scenario 'and dont view profile from another enterprise' do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22')
    another_enterprise = Enterprise.create!(name: 'Comp Tec', cnpj: '91.359.154/0001-20',
                                            email: 'contato@comptec.com',country: 'Brasil',
                                            state: 'São Paulo', address: 'Rua Quatro, 44')
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
    second_user = User.create!(email: 'ana.santos@estrela.com', password: '123456')
    third_user = User.create!(email: 'lucas.silva@comptec.com', password: '123456')
    profile = Profile.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                              birth_date: '02/12/1992', role: 'Dev', enterprise: enterprise,
                              department: 'Tecnologia', cpf: '541.268.930-24', user: user)
    second_profile = Profile.create!(full_name: 'Ana Santos', social_name: 'Ana',
                                     birth_date: '01/11/1993', role: 'Vendedora',
                                     department: 'Comercial', cpf: '923.176.840-96',
                                     user: second_user, enterprise: enterprise)
    third_profile = Profile.create!(full_name: 'Lucas Silva e Silva', social_name: 'Lucas',
                                    birth_date: '11/02/1999', role: 'Contador',
                                    department: 'Financeiro', cpf: '209.902.990-31',
                                    user: third_user, enterprise: another_enterprise)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Perfis'

    expect(page).to have_content('Ana - Comercial')
    expect(page).to_not have_content('Lucas - Financeiro')
  end

  scenario 'and dont see the cpf' do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                      state: 'São Paulo', address: 'Rua Dois, 22')
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
    second_user = User.create!(email: 'ana.santos@estrela.com', password: '123456')
    profile = Profile.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                              birth_date: '02/12/1992', role: 'Dev', enterprise: enterprise,
                              department: 'Tecnologia', cpf: '541.268.930-24', user: user)
    second_profile = Profile.create!(full_name: 'Ana Santos', social_name: 'Ana',
                                     birth_date: '01/11/1993', role: 'Vendedora',
                                     department: 'Comercial', cpf: '923.176.840-96',
                                     user: second_user, enterprise: enterprise)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Perfis'
    click_on 'Ana - Comercial'

    expect(page).to have_content('Ana Santos')
    expect(page).to have_content('Comercial')
    expect(page).to have_content('Vendedora')
    expect(page).to have_content('Alimentos Estrela')
    expect(page).to have_content('ana.santos@estrela.com')
    expect(page).to_not have_content('923.176.840-96')
  end

  scenario 'from announced product' do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                      state: 'São Paulo', address: 'Rua Dois, 22')
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
    second_user = User.create!(email: 'ana.santos@estrela.com', password: '123456')
    profile = Profile.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                              birth_date: '02/12/1992', role: 'Dev', enterprise: enterprise,
                              department: 'Tecnologia', cpf: '541.268.930-24', user: user)
    second_profile = Profile.create!(full_name: 'Ana Santos', social_name: 'Ana',
                                     birth_date: '01/11/1993', role: 'Vendedora',
                                     department: 'Comercial', cpf: '923.176.840-96',
                                     user: second_user, enterprise: enterprise)
    product = Product.create!(name: 'Panela', category: 'Cozinha', price: '50,00',
                              description: 'Panela pouco usada com pequenos arranhados',
                              profile: second_profile)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Produtos'
    click_on 'Panela - R$ 50,00'
    click_on 'Ana'

    expect(page).to have_content('Ana Santos')
    expect(page).to have_content('Comercial')
    expect(page).to have_content('Vendedora')
    expect(page).to have_content('Alimentos Estrela')
    expect(page).to have_content('ana.santos@estrela.com')
    expect(page).to_not have_content('923.176.840-96')
  end
end