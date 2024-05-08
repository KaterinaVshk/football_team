FactoryBot.define do
  factory :match_indicator do
    association :player, factory: :player
    association :indicator, factory: :indicator
    association :match, factory: :match
  end
end
