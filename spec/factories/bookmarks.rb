FactoryBot.define do
  factory :bookmark do
    association :video
    user { video.user }
  end
end
