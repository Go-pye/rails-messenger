FactoryBot.define do
  factory :conversation do
    association :participant1, factory: :user
    association :participant2, factory: :user
  end
end
