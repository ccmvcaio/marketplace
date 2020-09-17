feature 'Employee announce a product' do
  scenario 'successfully' do
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
    click_on 'Anunciar um produto'

    fill_in 'Nome', with: 'Panela'
    fill_in 'Categoria', with: 'Cozinha'
    fill_in 'Preço', with: '50,00'
    fill_in 'Descrição', with: 'Panela usada com poucos arranhados'
    attach_file 'Imagens', Rails.root.join('spec/support/panela.jpg')
    click_on 'Confirmar'

    expect(page).to have_content('Panela')
    expect(page).to have_content('Cozinha')
    expect(page).to have_content('R$ 50,00')
    expect(page).to have_content('Panela usada com poucos arranhados')
    expect(page).to have_css('img[src*="panela.jpg"]')
    expect(page).to have_link('Voltar', href: products_path)
  end

  scenario 'and must be loged in' do
    visit new_product_path

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'and must fill all blanks' do
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
    click_on 'Anunciar um produto'
    click_on 'Confirmar'

    expect(page).to have_content('não pode ficar em branco', count: 4)
  end
end