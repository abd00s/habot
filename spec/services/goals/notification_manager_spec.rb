require "rails_helper"

module Goals
  RSpec.describe NotificationManager do
    describe ".run" do
      let(:goal_frequency) { 2 }
      let(:goal) { create(:goal, frequency: goal_frequency) }

      it "invoked the SMS delivery service" do
        expected_arguments = {
          phone_number: Rails.application.credentials.test_data[:phone_number],
          message:      Goals::ProgressNotification.compose(goal: goal)
        }
        Aws::Sns::Sms.expects(:send_single).with(expected_arguments)

        Goals::NotificationManager.run(goal: goal)
      end
    end
  end
end
