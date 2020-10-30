FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "usuario#{i}@email.com.br" }
    password { '123456' }
  end
end