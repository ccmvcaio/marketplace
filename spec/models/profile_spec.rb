require 'rails_helper'

RSpec.describe Profile, type: :model do
  context 'CPF' do
    it 'must have eleven numbers' do
    user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')
    profile = Profile.create(full_name: 'José Maria', social_name: 'Zé', 
                              birth_date: '02/12/1992', role: 'Dev',
                              department: 'Tecnologia', cpf: '541.268.930',
                              user: user)
    
    fail = profile.errors.full_messages

    expect(fail).to include('CPF inválido')
    end
  end
end
