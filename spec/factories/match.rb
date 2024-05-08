FactoryBot.define do
  factory :match do
    ended_at { 2.day.ago }

    association :first_team, factory: :team
    association :second_team, factory: :team
  end
end
