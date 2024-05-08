FactoryBot.define do
  factory :player do
    name { 'Lamine' }
    surname { 'Yamal' }
    player_number { 27 }

    association :team, factory: :team
  end
end
