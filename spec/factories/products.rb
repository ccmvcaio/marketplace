FactoryBot.define do
  factory :product do
    sequence(:name) { |i| "Chinelinho#{i}" }
    category { 'Roupa' }
    price { '19.99' }
    description { 'Chinelo do Batman' }
    profile
    status { :available }
  end
end