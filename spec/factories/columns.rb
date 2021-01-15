FactoryBot.define do
  factory :column do
    title { Faker::Music::Prince.album.truncate(55) }
    association :board
  end
end
