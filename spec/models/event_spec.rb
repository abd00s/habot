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

  context "in a raw SQL INSERT" do
    let!(:event) { create(:event) }

    it "does not allow duplicate values on `goal_period` and `date`" do
      assert_raises ActiveRecord::RecordNotUnique do
        insert_duplicate_record
      end
    end
  end

  def insert_duplicate_record
    connection.execute <<-SQL
      INSERT INTO
        `events` (`goal_period_id`, `date`, `created_at`, `updated_at`)
      VALUES
        ("#{event.goal_period_id}", "#{event.date}", "#{now}", "#{now}")
    SQL
  end

  def connection
    @connection ||= ApplicationRecord.connection
  end

  def now
    @now ||= Time.zone.now.to_s(:db)
  end
end
