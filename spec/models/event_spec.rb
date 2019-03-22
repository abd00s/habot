require "rails_helper"

RSpec.describe Event, type: :model do
  it "validates presence of required fields" do
    should validate_presence_of(:goal_id)
    should validate_presence_of(:date)
  end

  it "has the correct associations" do
    should belong_to(:goal)
  end
end
