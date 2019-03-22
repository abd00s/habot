require "rails_helper"

RSpec.describe Goal, type: :model do
  it "validates presence of required fields" do
    should validate_presence_of(:user_id)
    should validate_presence_of(:title)
    should validate_presence_of(:frequency)
    should validate_presence_of(:period)
  end

  it "has the correct associations" do
    should have_many(:events)
    should belong_to(:user)
  end
end
