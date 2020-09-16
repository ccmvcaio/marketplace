feature 'Buyer view historic' do
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
    pan = Product.create!(name: 'Panela', category: 'Cozinha', price: '50,00',
                          description: 'Panela pouco usada, com poucos arranhões',
                          profile: second_profile, status: :sold)
    sale = Sale.create!(final_price: '60,00', product: pan, profile: profile)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Compras/Vendas'

    expect(current_path).to eq sales_path
    expect(page).to have_content('Panela R$ 60,00')
  end

  scenario 'and view products waiting confirmation' do
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
    pan = Product.create!(name: 'Panela', category: 'Cozinha', price: '50,00',
                          description: 'Panela pouco usada, com poucos arranhões',
                          profile: second_profile, status: :waiting_confirmation)
    sale = Sale.create!(final_price: '60,00', product: pan, profile: profile)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Compras/Vendas'

    expect(current_path).to eq sales_path
    expect(page).to have_content('Panela R$ 60,00')
  end

  scenario 'and view sold product details' do
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
    pan = Product.create!(name: 'Panela', category: 'Cozinha', price: '50,00',
                          description: 'Panela pouco usada, com poucos arranhões',
                          profile: second_profile, status: :sold)
    sale = Sale.create!(final_price: '60,00', product: pan, profile: profile)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Compras/Vendas'
    click_on 'Panela R$ 60,00'

    expect(page).to have_content('Panela')
    expect(page).to have_content('Cozinha')
    expect(page).to have_content('Panela pouco usada, com poucos arranhões')
    expect(page).to have_content('Preço final')
    expect(page).to have_content('R$ 60,00')
    expect(page).to have_content('Vendido')
    expect(page).to_not have_content('Comprar')
    expect(page).to_not have_content('Confirmar venda')
    expect(page).to_not have_content('Aguardando confirmação')
  end

  scenario 'and view waiting confirmation product details' do
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
    pan = Product.create!(name: 'Panela', category: 'Cozinha', price: '50,00',
                          description: 'Panela pouco usada, com poucos arranhões',
                          profile: second_profile, status: :waiting_confirmation)
    sale = Sale.create!(final_price: '60,00', product: pan, profile: profile)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Compras/Vendas'
    click_on 'Panela R$ 60,00'

    expect(page).to have_content('Panela')
    expect(page).to have_content('Cozinha')
    expect(page).to have_content('Panela pouco usada, com poucos arranhões')
    expect(page).to have_content('Aguardando confirmação')
    expect(page).to_not have_content('Comprar')
    expect(page).to_not have_content('Confirmar venda')
  end
end