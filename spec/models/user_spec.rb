require 'rails_helper'

RSpec.describe User, type: :model do
  context 'set email domain' do
    it 'should return the email domain of an user' do
      user = User.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                      email: 'caio.valerio@estrela.com', password: '123456',
                      date_of_birth: '02/02/1992', role: 'Dev', department: 'Tecnologia',
                      cpf: '541.268.930-24')

      domain = user.email_domain

      expect(domain).to eq 'estrela.com'
    end
  end

  xcontext 'CPF' do
    it 'must be valid' do
      user = User.create!(full_name: 'Caio Valério', social_name: 'Caio César', 
                      email: 'caio.valerio@estrela.com', password: '123456',
                      date_of_birth: '02/02/1992', role: 'Dev', department: 'Tecnologia',
                      cpf: '541.268.930-24')
      another_user = User.create!(full_name: 'José Silva', social_name: 'José', 
                      email: 'jose.silva@estrela.com', password: '123456',
                      date_of_birth: '01/01/1991', role: 'Adm', department: 'Financeiro',
                      cpf: '541.268.930-24')
      
      
    end

    it 'must be unique' do

    end
  end
end
