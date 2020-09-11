feature 'Seller view sales' do
  scenario 'successfully' do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22')
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
    profile = Profile.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                              birth_date: '02/12/1992', role: 'Dev',
                              department: 'Tecnologia', cpf: '541.268.930-24', user: user,
                              enterprise: enterprise)
    pan = Product.create!(name: 'Panela', category: 'Cozinha', price: '50,00',
                          description: 'Panela pouco usada, com poucos arranhões',
                          profile: profile, status: :waiting_confirmation)
    tire = Product.create!(name: 'Pneu', category: 'Carro', price: '250,00',
                           description: 'Pneu novo aro 15', profile: profile,
                           status: :sold)
    flip_flop = Product.create!(name: 'Chinelo', category: 'Vestuário', price: '20,00',
                                description: 'Chinelo do Dragon Ball', profile: profile,
                                status: :available)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Vendas'
  
    expect(page).to have_content('Panela - Aguardando confirmação')
    expect(page).to have_content('Pneu - Vendido')
    expect(page).to have_content('Chinelo - Disponível')
  end

  scenario 'and view product details' do
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

    expect(page).to have_content('Panela')
    expect(page).to have_content('Cozinha')
    expect(page).to have_content('50,00')
    expect(page).to have_content('Panela pouco usada, com poucos arranhões')
    expect(page).to have_content('Aguardando confirmação de venda')
  end

  scenario 'and view sale details' do
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

    expect(page).to have_content('Panela')
    expect(page).to have_content('Cozinha')
    expect(page).to have_content('R$ 50,00')
    expect(page).to have_content('Panela pouco usada, com poucos arranhões')
    expect(page).to have_content('Ana')
    expect(page).to have_content('R$ 60,00')
  end

  scenario 'and view buyers details' do
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
    click_on 'Ana'

    expect(page).to have_content('Ana Santos')
    expect(page).to have_content('Comercial')
    expect(page).to have_content('Vendedora')
    expect(page).to have_content('Alimentos Estrela')
  end

  scenario 'and must be logged in' do
    visit sales_path

    expect(current_path).to eq new_user_session_path
  end
end