require 'rails_helper'

feature 'User view enterprises registered' do
  scenario 'successfully' do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22')
    another_enterprise = Enterprise.create!(name: 'Comp Tec', cnpj: '91.359.154/0001-20',
                                            email: 'contato@comptec.com',
                                            country: 'Brasil', state: 'São Paulo', 
                                            address: 'Rua Quatro, 44')
    
    visit root_path
    click_on 'Empresas cadastradas'

    expect(page).to have_content('Empresas cadastradas')
    expect(page).to have_content('Alimentos Estrela')
    expect(page).to have_content('Comp Tec')
    expect(page).to have_link('Voltar', href: root_path)
  end

  scenario 'and dont see details of the enterprises' do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22')
    another_enterprise = Enterprise.create!(name: 'Comp Tec', cnpj: '91.359.154/0001-20',
                                            email: 'contato@comptec.com',
                                            country: 'Brasil', state: 'São Paulo', 
                                            address: 'Rua Quatro, 44')

  visit root_path
  click_on 'Empresas cadastradas'

  expect(page).to_not have_content('41.736.335/0001-50')
  expect(page).to_not have_content('comercial@estrela.com')
  expect(page).to_not have_content('Brasil')
  expect(page).to_not have_content('São Paulo')
  expect(page).to_not have_content('Rua Dois, 22')
  expect(page).to_not have_content('91.359.154/0001-20')
  expect(page).to_not have_content('contato@comptec.com')
  expect(page).to_not have_content('Rua Quatro, 44')
  end
end