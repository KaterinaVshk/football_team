FactoryBot.define do
  factory :player do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    player_number {  Random.rand(100000) }

    association :team, factory: :team
  end
end
