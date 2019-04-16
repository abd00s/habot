require "rails_helper"

RSpec.describe BeginningOfWeekValidator, type: :model do
  StartDateValidatable = Struct.new(:start_date) do
    include ActiveModel::Validations

    validates :start_date, beginning_of_week: true
  end

  subject { StartDateValidatable.new }

  let(:monday) { Time.zone.today.beginning_of_week }

  it "allows Monday for `start_date`" do
    should allow_value(monday).for(:start_date)
  end

  it "doesn't allow other days than Monday for `start_date`" do
    non_mondays = (1..6).map { |i| monday + i }
    non_mondays.each do |day|
      should_not allow_value(day).for(:start_date)
    end
  end
end
