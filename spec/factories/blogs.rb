FactoryBot.define do
  factory :blog do
    title { Faker::Lorem.word }
    body { Faker::Lorem.paragraph }
    user
  end
end