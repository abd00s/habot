FactoryBot.define do
  factory :goal do
    user
    title { "Sample Goal" }
    frequency { 3 }
    period { "week" }
  end
end
