feature 'Seller edit product' do
  scenario 'successfully'  do
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
    click_on 'Editar produto'
    fill_in 'Nome', with: 'Panela de pressão'
    fill_in 'Categoria', with: 'Cozinha'
    fill_in 'Preço', with: '80,00'
    fill_in 'Descrição', with: 'Panela de pressão em bom estado'
    click_on 'Confirmar'

    expect(page).to have_content('Panela de pressão')
    expect(page).to have_content('Cozinha')
    expect(page).to have_content('80,00')
    expect(page).to have_content('Panela de pressão em bom estado')
    expect(page).to have_content('Caio César')
  end
end