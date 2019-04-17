require "rails_helper"

RSpec.describe Event, type: :model do
  it "runs the required validations" do
    should validate_presence_of(:goal_period_id)
    should validate_presence_of(:date)
    should validate_uniqueness_of(:date).scoped_to(:goal_period_id)
  end

  it "has the correct associations" do
    should belong_to(:goal_period)
  end
end
