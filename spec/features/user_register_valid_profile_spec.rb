feature 'User register valid profile' do
  scenario 'successfully' do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22')
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Perfis'
    click_on 'Meu perfil'
    fill_in 'Nome completo', with: 'Caio César Valério'
    fill_in 'Nome social', with: 'Caio César'
    fill_in 'Cargo', with: 'Desenvolvedor Júnior'
    fill_in 'Setor', with: 'Tecnologia'
    fill_in 'CPF', with: '541.268.930-24'
    fill_in 'Data de nascimento', with: '02/12/1992'
    click_on 'Registrar'

    expect(page).to have_content('Caio César Valério')
    expect(page).to have_content('Caio César')
    expect(page).to have_content('Desenvolvedor Júnior')
    expect(page).to have_content('Tecnologia')
    expect(page).to have_content('541.268.930-24')
    expect(page).to have_content('caio.valerio@estrela.com')
  end

  scenario 'and must not be blank' do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22')
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Perfis'
    click_on 'Meu perfil'
    fill_in 'Data de nascimento', with: ''
    click_on 'Registrar'

    expect(page).to have_content('não pode ficar em branco', count: 6)
  end

  scenario 'and cpf must be unique' do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22')
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
    other_user = User.create!(email: 'jose.maria@estrela.com', password: '123456')
    other_profile = Profile.create!(full_name: 'José Maria', social_name: 'Zé', 
                                    birth_date: '02/12/1992', role: 'Dev',
                                    department: 'Tecnologia', cpf: '541.268.930-24',
                                    user: other_user, enterprise: enterprise)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Perfis'
    click_on 'Meu perfil'
    fill_in 'Nome completo', with: 'Caio César Valério'
    fill_in 'Nome social', with: 'Caio César'
    fill_in 'Cargo', with: 'Desenvolvedor Júnior'
    fill_in 'Setor', with: 'Tecnologia'
    fill_in 'CPF', with: '541.268.930-24'
    fill_in 'Data de nascimento', with: '02/12/1992'
    click_on 'Registrar'

    expect(page).to have_content('CPF já está em uso')
  end

  scenario 'and CPF must be valid'  do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22')
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Perfis'
    click_on 'Meu perfil'
    fill_in 'Nome completo', with: 'Caio César Valério'
    fill_in 'Nome social', with: 'Caio César'
    fill_in 'Cargo', with: 'Desenvolvedor Júnior'
    fill_in 'Setor', with: 'Tecnologia'
    fill_in 'CPF', with: '12.123.123-12'
    fill_in 'Data de nascimento', with: '02/12/1992'
    click_on 'Registrar'

    expect(page).to have_content('CPF inválido')
  end
end