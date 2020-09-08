require 'rails_helper'

RSpec.describe Enterprise, type: :model do
  context 'set email domain' do
    it 'should be the same as enterprise email' do
      enterprise = Enterprise.create!(name: 'Alimentos Estrela', cnpj: '41.736.335/0001-50',
                                    email: 'comercial@estrela.com', country: 'Brasil',
                                    state: 'São Paulo', address: 'Rua Dois, 22')
  
      domain = enterprise.domain

      expect(domain).to eq 'estrela.com'
    end
  end
end
