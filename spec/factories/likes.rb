FactoryBot.define do
  factory :like do
    association :output
    user { output.user }
  end
end
