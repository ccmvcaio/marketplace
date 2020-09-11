feature 'Employee view products comments' do
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
    comment = Comment.create!(send_date: Date.current, body: 'Qual motivo da venda?',
                              profile: second_profile, product: product)
    second_comment = Comment.create!(send_date: Date.current, body: 'Tem ferrugem?',
                                     profile: second_profile, product: product)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Produtos'
    click_on 'Panela - R$ 50,00'

    expect(page).to have_content('Panela')
    expect(page).to have_content('Cozinha')
    expect(page).to have_content('R$ 50,00')
    expect(page).to have_content('Panela pouco usada com pequenos arranhados')
    expect(page).to have_link('Ana')
    expect(page).to have_content('Qual motivo da venda?')
    expect(page).to have_content('Tem ferrugem?')
  end
end