feature 'user sign in' do
  scenario 'and visit login page'  do
    visit root_path
    click_on 'Entrar'

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully' do
    visit root_path
    click_on 'Entrar'
    click_on 'Registrar-se'
    fill_in 'Email', with: 'teste@teste.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Enviar'

    expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
    expect(current_path).to eq root_path
  end

  scenario 'and logs in' do
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
  
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'caio.valerio@estrela.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
    
    expect(page).to have_content('Market Place')
    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to_not have_link('Entrar')
    expect(page).to have_link('Sair')
  end

  scenario 'and logs out' do
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
            
    login_as(user, scope: :user)
    visit root_path
    click_on 'Sair'

    expect(page).to_not have_link('Sair')
    expect(page).to have_link('Entrar')
    expect(current_path).to eq root_path
    expect(page).to have_content('Logout efetuado com sucesso.')
  end
end