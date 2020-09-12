feature 'Seller finish a sale' do
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
    select 'Vender', from: 'Autorizar venda'
    click_on 'Confirmar'

    expect(page).to have_content('Panela - Vendido')
    expect(pan.reload).to be_sold
  end

  scenario 'and must not view sold products on products page' do
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
                          profile: profile, status: :sold)
    flip_flop = Product.create!(name: 'Chinelo', category: 'Vestuário', price: '20,00',
                                description: 'Chinelo do Dragon Ball',
                                profile: second_profile, status: :available)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content('Chinelo - R$ 20,00')
    expect(page).to_not have_content('Panela - R$ 50,00')
  end
end