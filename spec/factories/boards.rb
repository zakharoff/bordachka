FactoryBot.define do
  factory :board do
    title { Faker::Movie.title.truncate(30) }
    description { Faker::Movie.quote.truncate(255) }
    img_url { 'https://images.unsplash.com/photo-1506991458536-26f8f5885c4a' }
    slug { '123456' }
    association :author, factory: :user
  end
end
