require 'rails_helper'

feature 'User view enterprise' do
  scenario 'and must be logged in'do
    visit root_path
    click_on 'Empresa'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'successfully' do
    user = User.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                    email: 'caio.valerio@estrela.com', password: '123456',
                    date_of_birth: '02/02/1992', role: 'Dev', department: 'Tecnologia',
                    cpf: '541.268.930-24')
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22',
                                    domain: 'estrela.com')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresa'

    expect(page).to have_content('Empresa:')
    expect(page).to have_content('Alimentos Estrela')
    expect(page).to have_content('41.736.335/0001-50')
    expect(page).to have_content('comercial@estrela.com')
    expect(page).to have_content('Brasil')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('Rua Dois, 22')
    expect(page).to have_link('Voltar', href: root_path)
  end

  xscenario 'and see only user enterprise' do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22',
                                    domain: 'estrela.com')
    another_enterprise = Enterprise.create!(name: 'Comp Tec', cnpj: '91.359.154/0001-20',
                                            email: 'contato@comptec.com',country: 'Brasil',
                                            state: 'São Paulo', address: 'Rua Quatro, 44',
                                            domain: 'comptec.com')

  visit root_path
  click_on 'Empresas'

  expect(page).to have_content('Alimentos Estrela')
  expect(page).to have_content('41.736.335/0001-50')
  expect(page).to have_content('comercial@estrela.com')
  expect(page).to have_content('Brasil', conut: 1)
  expect(page).to have_content('São Paulo', count: 1)
  expect(page).to have_content('Rua Dois, 22')
  expect(page).to_not have_content('CompTec')
  expect(page).to_not have_content('91.359.154/0001-20')
  expect(page).to_not have_content('contato@comptec.com')
  expect(page).to_not have_content('Rua Quatro, 44')
  end
end