feature 'Seller cancel sale' do
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
                          profile: profile, status: :waiting_confirmation)
    sale = Sale.create!(final_price: '60,00', product: pan, profile: second_profile)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Vendas'
    click_on 'Panela - Aguardando confirmação'
    click_on 'Confirmar venda'
    select 'Cancelar', from: 'Autorizar venda'
    click_on 'Confirmar'

    expect(page).to have_content('Panela')
    expect(page).to have_content('Cozinha')
    expect(page).to have_content('R$ 50,00')
    expect(page).to have_content('Panela pouco usada, com poucos arranhões')
    expect(page).to_not have_content('Panela - Vendido')
    expect(page).to_not have_content('R$ 60,00')
    expect(page).to_not have_content('Panela - Aguardando confirmação')
    expect(current_path).to eq product_path(pan.id)
  end

  scenario 'and product be available' do
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
                          profile: profile, status: :waiting_confirmation)
    sale = Sale.create!(final_price: '60,00', product: pan, profile: second_profile)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Vendas'
    click_on 'Panela - Aguardando confirmação'
    click_on 'Confirmar venda'
    select 'Cancelar', from: 'Autorizar venda'
    click_on 'Confirmar'
    
    pan.reload
    expect(pan.status).to eq 'available'
  end

  scenario 'and must have no sale attached' do
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
                          profile: profile, status: :waiting_confirmation)
    sale = Sale.create!(final_price: '60,00', product: pan, profile: second_profile)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Vendas'
    click_on 'Panela - Aguardando confirmação'
    click_on 'Confirmar venda'
    select 'Cancelar', from: 'Autorizar venda'
    click_on 'Confirmar'

    pan.reload
    expect(pan.sale).to eq nil
  end

  scenario 'and must be on products page again' do
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
                          profile: profile, status: :waiting_confirmation)
    sale = Sale.create!(final_price: '60,00', product: pan, profile: second_profile)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Vendas'
    click_on 'Panela - Aguardando confirmação'
    click_on 'Confirmar venda'
    select 'Cancelar', from: 'Autorizar venda'
    click_on 'Confirmar'
    visit products_path

    expect(current_path).to eq products_path
    expect(page).to have_link('Panela - R$ 50,00', href: product_path(pan.id))
  end
end