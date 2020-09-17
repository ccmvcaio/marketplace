feature 'seller delete product' do
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
                          profile: profile, status: :available)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Produtos'
    click_on 'Panela - R$ 50,00'
    click_on 'Apagar produto'

    expect(current_path).to eq products_path
    expect(page).to have_content('Nenhum produto encontrado')
  end

  scenario 'and dont delete another product' do
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
                          profile: profile, status: :available)
    flip_flop = Product.create!(name: 'Chinelo', category: 'Vestuário', price: '20,00',
                                description: 'Chinelo do Dragon Ball',
                                profile: profile, status: :available)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Produtos'
    click_on 'Panela - R$ 50,00'
    click_on 'Apagar produto'

    expect(current_path).to eq products_path
    expect(page).to have_link('Chinelo - R$ 20,00')
    expect(page).to_not have_content('Panela - R$ 50,00')
  end
end