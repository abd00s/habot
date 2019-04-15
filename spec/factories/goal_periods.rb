FactoryBot.define do
  factory :goal_period do
    goal { nil }
    start_date { "2019-04-15 12:59:05" }
    goal_met { false }
  end
end
