require "rails_helper"

RSpec.describe User, type: :model do
  it "validates presence of required fields" do
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
  end

  it "has the correct associations" do
    should have_many(:goals)
  end
end
