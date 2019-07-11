require "rails_helper"
require "sidekiq/testing"

RSpec.describe QueueGoalsProgressNotificationsWorker, type: :worker do
  describe "#perform" do
    before { 3.times { create(:goal) } }

    it "queues the notification worker for each goal" do
      ProgressNotificationWorker.jobs.clear

      expect { QueueGoalsProgressNotificationsWorker.new.perform }.to(
        change { ProgressNotificationWorker.jobs.size }.from(0).to(3)
      )
    end
  end
end
