feature 'User view profile' do
  scenario 'and must be loged in' do
    visit root_path
    click_on 'Perfis'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'successfully' do
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
    profile = Profile.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                        birth_date: '02/12/1992', role: 'Dev',
                        department: 'Tecnologia', cpf: '541.268.930-24', user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Perfis'
    click_on 'Meu perfil'

    expect(page).to have_content('Caio Valério')
    expect(page).to have_content('Caio César')
    expect(page).to have_content('02/12/1992')
    expect(page).to have_content('Dev')
    expect(page).to have_content('Tecnologia')
    expect(page).to have_content('541.268.930-24')
    expect(page).to have_content('caio.valerio@estrela.com')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home' do
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
    profile = Profile.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                        birth_date: '02/12/1992', role: 'Dev',
                        department: 'Tecnologia', cpf: '541.268.930-24', user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Perfis'
    click_on 'Voltar'

    expect(page).to have_content('Market Place')
    expect(current_path).to eq root_path
  end

  scenario 'and return to profiles path' do
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
    profile = Profile.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                        birth_date: '02/12/1992', role: 'Dev',
                        department: 'Tecnologia', cpf: '541.268.930-24', user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Perfis'
    click_on 'Meu perfil'
    click_on 'Voltar'

    expect(page).to have_content('Perfis')
    expect(current_path).to eq profiles_path
  end
end