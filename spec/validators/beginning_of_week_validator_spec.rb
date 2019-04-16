require "rails_helper"

RSpec.describe BeginningOfWeekValidator, type: :model do
  let(:goal_period) { build(:goal_period) }

  let(:monday) { Time.zone.today.beginning_of_week }

  it "allows Monday for `start_date`" do
    expect(goal_period).to allow_value(monday).for(:start_date)
  end

  it "doesn't allow other days than Monday for `start_date`" do
    non_mondays = (1..6).map { |i| monday + i }
    non_mondays.each do |day|
      expect(goal_period).not_to allow_value(day).for(:start_date)
    end
  end
end
