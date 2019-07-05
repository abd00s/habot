module Goals
  class NotificationManager
    def self.run(goal:)
      new(goal).tap(&:run)
    end

    def initialize(goal)
      @goal = goal
    end

    def run
      Aws::Sns::Sms.send_single(
        phone_number: Rails.application.credentials.test_data[:phone_number],
        message:      Goals::ProgressNotification.compose(goal: @goal)
      )
    end
  end
end
