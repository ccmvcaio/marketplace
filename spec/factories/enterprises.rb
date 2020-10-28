FactoryBot.define do
  factory :enterprise do
    sequence(:name) { |i| "Empresa #{i}" }
    cnpj { '09.839.618/0001-14' }
    email { 'lorem@email.com.br' }
    country { 'Brasil' }
    state { 'São Paulo' }
    address { 'Rua dos Oliveiras, 101' }
  end
end