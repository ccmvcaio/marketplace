require 'rails_helper'

feature 'User view enterprise' do
  scenario 'and must be logged in'do
    visit root_path
    click_on 'Empresa'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'successfully' do
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22')
    
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

  scenario 'and see only user enterprise' do
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22',)
    another_enterprise = Enterprise.create!(name: 'Comp Tec', cnpj: '91.359.154/0001-20',
                                            email: 'contato@comptec.com',country: 'Brasil',
                                            state: 'São Paulo', address: 'Rua Quatro, 44')

  login_as(user, scope: :user)
  visit root_path
  click_on 'Empresa'

  expect(page).to have_content('Alimentos Estrela')
  expect(page).to have_content('41.736.335/0001-50')
  expect(page).to have_content('comercial@estrela.com')
  expect(page).to have_content('Brasil')
  expect(page).to have_content('São Paulo')
  expect(page).to have_content('Rua Dois, 22')
  expect(page).to_not have_content('Comp Tec')
  expect(page).to_not have_content('91.359.154/0001-20')
  expect(page).to_not have_content('contato@comptec.com')
  expect(page).to_not have_content('Rua Quatro, 44')
  end

  scenario 'and must have an enterprise domain' do
    user = User.create!(email: 'caio.valerio@gmail.com', password: '123456')
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22',)
  
    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresa'

    expect(page).to have_content('Conta inválida')
    expect(page).to have_content('Verificar com a empresa responsável')
    expect(page).to_not have_content('Alimentos Estrela')
  end
end