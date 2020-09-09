xfeature 'User register valid profile' do
  scenario 'successfully' do
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
end