FactoryBot.define do
  factory :profile do
    sequence(:full_name) { |i| "Lorem#{i} Ipsum#{i}" }
    sequence(:social_name) { |i| "Lorem#{i}" }
    sequence(:birth_date) { |i| "0#{i}/12/1992" }
    role { 'Dev' }
    department { 'Tecnologia' }
    cpf  { '541.268.930-24' }
    user
    enterprise
  end
end