require "rails_helper"

RSpec.describe BeginningOfWeekValidator, type: :model do
  let(:goal_period) { build(:goal_period) }

  let(:monday) { Time.zone.today.beginning_of_week }
  let(:tuesday) { monday + 1 }

  it "allows `monday` for `start_date`" do
    expect(goal_period).to allow_value(monday).for(:start_date)
  end

  it "doesn't allow `Tuesday` for `start_date`" do
    expect(goal_period).not_to allow_value(tuesday).for(:start_date)
  end
end
