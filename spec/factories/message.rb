FactoryBot.define do
  factory :message do
    content { "MyText" }
    user
    conversation
  end
end