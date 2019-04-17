FactoryBot.define do
  factory :event do
    goal_period
    date { Time.zone.now }
  end
end
