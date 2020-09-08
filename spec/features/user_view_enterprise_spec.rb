require 'rails_helper'

feature 'User view enterprise' do
  scenario 'successfully' do
    enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22',
                                    domain: 'estrela.com')
    
    visit root_path
    click_on 'Empresa'

    expect(page).to have_content('Empresa:')
    expect(page).to have_content('Alimentos Estrela')
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