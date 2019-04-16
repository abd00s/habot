require "rails_helper"

RSpec.describe GoalPeriod, type: :model do
  it "runs required validations" do
    should validate_presence_of(:goal_id)
    should validate_presence_of(:start_date)
    should validate_with(BeginningOfWeekValidator).for_attribute(:start_date)
  end

  it "has the correct associations" do
    should belong_to(:goal)
    should have_many(:events)
  end

  context "with an invalid start_date" do
    let(:tuesday) { Time.zone.now.beginning_of_week + 1.day }
    subject { create(:goal_period) }

    before(:each) do
      subject.start_date = tuesday
    end

    it "makes the record invalid" do
      expect(subject).to_not be_valid
    end

    it "should raise invalid record with an invalid start_date" do
      expected_message = I18n.t(
        :week_start,
        scope: "activerecord.errors.models.goal_period.attributes.start_date"
      )
      expect { subject.save! }.to raise_error ActiveRecord::RecordInvalid,
                                              /#{expected_message}/
    end
  end
end
