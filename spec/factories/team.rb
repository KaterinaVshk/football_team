FactoryBot.define do
  factory :team do
    name { Faker::Team.name }
    country_name { Faker::Address.country }
  end
end