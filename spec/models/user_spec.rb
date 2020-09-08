require 'rails_helper'

RSpec.describe User, type: :model do
  context 'set email domain' do
    it 'should return the email domain of an user' do
      user = User.create!(email: 'caio.valerio@estrela.com', password: '123456')

      domain = user.email_domain

      expect(domain).to eq 'estrela.com'
    end
  end
end
