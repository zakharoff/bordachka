FactoryBot.define do
  factory :card do
    title { Faker::Games::WorldOfWarcraft.hero.truncate(60) }
    body { Faker::Games::WorldOfWarcraft.quote.truncate(140) }
    association :author, factory: :user
    association :board
    association :column
  end
end
