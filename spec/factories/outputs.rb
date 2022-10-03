FactoryBot.define do
  factory :output do
    summary { 'summary' }
    impression { 'impression' }
    association :user
    association :video
  end
end
