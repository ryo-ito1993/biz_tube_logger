FactoryBot.define do
  factory :comment do
    association :output
    user { output.user }
    body { 'comment' }
  end
end
