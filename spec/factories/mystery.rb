FactoryBot.define do
  factory :mystery do
    user_id { 1 }
    title { Faker::Lorem.characters(number:5) }
    discription { Faker::Lorem.characters(number:20) }
    answer { Faker::Lorem.characters(number:5) }
    answer_discription { Faker::Lorem.characters(number:20) }
    difficulty_level { 1.0 }
    is_opened { true }
  end
end