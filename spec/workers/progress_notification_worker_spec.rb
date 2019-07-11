require "rails_helper"

RSpec.describe ProgressNotificationWorker, type: :worker do
  describe ".perform_async" do
    let(:goal) { create(:goal) }

    it "calls the goal notification manager service for the goal" do
      Goals::NotificationManager.expects(:run).with(goal: goal)

      ProgressNotificationWorker.new.perform(goal.id)
    end
  end
end
