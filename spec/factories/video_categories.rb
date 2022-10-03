FactoryBot.define do
  factory :video_category do
    association :video
    association :category
  end
end
