FactoryBot.define do
  factory :goal_period do
    goal
    start_date { "2019-04-15" }
    goal_met { false }
  end
end
