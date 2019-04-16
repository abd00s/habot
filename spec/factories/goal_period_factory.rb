FactoryBot.define do
  factory :goal_period do
    goal
    start_date { Time.zone.now.beginning_of_week }
    goal_met { false }
  end
end
